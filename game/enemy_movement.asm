
Enemy_Movement_Table:
	LDA enemy_num_tablecheck
	ASL
	TAX

	LDA En_Move_RTS_table+1, x
	PHA	;push high byte
	LDA En_Move_RTS_table, X
	PHA 	;push low byte
	RTS	;launches our subroutine indexed by enemy_num_tablecheck

four_ens:
	LDA EnemyTrueFalse
	BEQ FirstTimeThrough

	LDA EnemyPointY
	CLC
	ADC #$04
	STA EnemyPointY

	LDA EnemyPointX
	CLC
	ADC #$04
	STA EnemyPointX

	LDA EnemyPointY
	CMP OAM_Num
	BNE EnStart

FirstTimeThrough:
	LDY #$00
	LDA En_Y+0, y
	STA EnemyPointY+0
	LDA En_Y+1, y
	STA EnemyPointY+1

	LDA En_X+0, y
	STA EnemyPointX+0
	LDA En_X+1, y
	STA EnemyPointX+1

	LDA #$01
	STA EnemyTrueFalse
	
EnStart:	
	LDA EnBit
	AND #%00000010
	BNE BottomWallFlag_Marked ;go up!
	LDA EnBit
	AND #%00000100
	BNE RightWallFlag_Marked ;go right!
	LDA EnBit
	AND #%00001000
	BNE LeftWallFlag_Marked ;go left!
	;; otherwise go down: EnBit = #$00
	JMP EnDown

BottomWallFlag_Marked:
	JSR EnUp
	JMP EnMovementDone
RightWallFlag_Marked:
	JSR TraverseRight
	JMP EnMovementDone
LeftWallFlag_Marked:
	JSR TraverseLeft
	JMP EnMovementDone
EnDown:
	LDA #%00000000
	STA EnBit
;;; store temporary x&y Enemy Location
	LDY #$00
	LDA (EnemyPointY), y
	STA temp_en_y_move
	LDA (EnemyPointX), y
	STA temp_en_x_move

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; check down movement
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	CMP #BOTTOMWALL
	BNE @GetDownTile
	JMP EnUp
@GetDownTile:
	JSR Tile_Translate
	CMP #$04
	BNE @CheckRock
	JSR BreakTree
	JMP EnMovementDone
@CheckRock:
	CMP #$3B
	BNE GoingDown
	JMP TraverseRight

GoingDown:
	DEC EnDownCounter
	BNE @Down
	LDA #$04
	STA EnDownCounter
	JMP TraverseRight
@Down:
	;; change to walking down sprite
	INC EnemyPointY
	LDY #$00
	LDA #$15
	STA (EnemyPointY), y
	DEC EnemyPointY
	
	LDY #$00
	LDA (EnemyPointY), y
	CLC
	ADC #$08
	STA (EnemyPointY), y

EnMovementDone:
	RTS
	
BreakTree:	
	;; Chop temp_en_y_move, temp_en_x_move, GetTile, EnPtr1, EnPtr2, offset
	LDA temp_en_x_move
	LDX temp_en_y_move
	JSR GetTile
	CMP #$3B
	BEQ ChopDone1
	LDA temp_en_x_move	;x coordinate
	LDX temp_en_y_move	;y coordinate
	;; divide x coordinate by 8 and store x-offset in variable
	lsr
	lsr
	lsr
	STA offset
	;; zero out Z+1 and get the lower bits
	lda #$00
	sta EnPtr1+1
	txa
	and #%11111000
	;; multiply y coordinate by 32
	asl
	rol EnPtr1+1
	asl
	rol EnPtr1+1
	;add the result to the base address of the NT
	adc ppu_base+0
	sta EnPtr1+0
	lda EnPtr1+1
	adc ppu_base+1
	sta EnPtr1+1
	;; add 
	LDA EnPtr1+0
	CLC
	ADC offset
	STA EnPtr1+0
	;; update PPU
	BIT $2002
vblankwaiter:
	BIT $2002
	BPL vblankwaiter
	LDA EnPtr1+1
	STA $2006
	LDA EnPtr1+0
	STA $2006
	LDA #$00
	STA $2007
	STA $2005
	STA $2005
ChopDone1:
	rts

Tile_Translate:
	LDA #$00
	STA M
	LDA temp_en_y_move
	AND #%11111000
	ASL
	ROL M
	ASL
	ROL M
	ADC #<PRGROM
	STA Z
	LDA M
	ADC #>PRGROM
	STA M
	LDA temp_en_x_move
	LSR
	LSR
	LSR
	TAY
	LDA (Z), Y

	rts

EnUp:	
	LDA #%00000010
	STA EnBit

	LDY #$00
	LDA (EnemyPointY), y
	CMP #TOPWALL
	BEQ TraverseRight
;;; store temporary x&y Enemy location
	LDY #$00
	LDA (EnemyPointY), y
	STA temp_en_y_move
	LDA (EnemyPointX), y
	STA temp_en_x_move
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; check up movement
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move

	;; LDA temp_en_y_move
	CMP #TOPWALL
	BNE @GetUpTile
	JMP EnMovementDone
@GetUpTile:
	JSR Tile_Translate
	CMP #$04
	BNE @CheckRock
	JSR BreakTree
	JMP EnMovementDone
@CheckRock:
	CMP #$3B
	BEQ TraverseRight

GoingUp:
	DEC EnUpCounter
	BNE @Up
	LDA #$04
	STA EnUpCounter
	JMP TraverseLeft
@Up:
	;; en goes back up if reached bottom wall
	INC EnemyPointY
	LDY #$00
	LDA #$25
	STA (EnemyPointY), y
	DEC EnemyPointY
	
	;; LDY #$00
	LDA (EnemyPointY), y
	SEC
	SBC #$08
	STA (EnemyPointY), y

	RTS
	
TraverseRight:
	LDA #%00000100
	STA EnBit
;;; store temporary x&y Enemy Location
	LDY #$00
	LDA (EnemyPointY), y
	STA temp_en_y_move
	LDA (EnemyPointX), y
	STA temp_en_x_move

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; check right movement
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move
	CMP #RIGHTWALL
	BNE @GetRightTile
	JMP TraverseLeft
@GetRightTile:
	JSR Tile_Translate
	CMP #$04
	BNE @CheckRock
	JSR BreakTree
	JMP EnMovementDone
@CheckRock:
	CMP #$3B
	BNE GoingRight
	JMP EnDown
	
GoingRight:
	DEC EnRightCounter
	BNE @Right
	LDA #$04
	STA EnRightCounter
	JMP EnDown
@Right:
	INC EnemyPointY
	LDY #$00
	LDA #$34
	STA (EnemyPointY), y
	DEC EnemyPointY
	
	LDY #$00
	LDA (EnemyPointX), y
	CLC
	ADC #$08
	STA (EnemyPointX), y
	
	RTS

TraverseLeft:	
	LDA #%00001000
	STA EnBit
;;; store temporary x&y Enemy Location
	LDY #$00
	LDA (EnemyPointY), y
	STA temp_en_y_move
	LDA (EnemyPointX), y
	STA temp_en_x_move

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; check left movement
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move
	CMP #LEFTWALL
	BNE @GetLeftTile
	JMP TraverseRight
@GetLeftTile:
	JSR Tile_Translate
	CMP #$04
	BNE @CheckRock
	JSR BreakTree
	JMP EnMovementDone
@CheckRock:
	CMP #$3B
	BNE GoingLeft
	JMP EnUp
	
GoingLeft:
	DEC EnLeftCounter
	BNE @Left
	LDA #$04
	STA EnLeftCounter
	JMP EnUp

@Left:
	INC EnemyPointY
	LDY #$00
	LDA #$24
	STA (EnemyPointY), y
	DEC EnemyPointY
	
	LDY #$00
	LDA (EnemyPointX), y
	SEC
	SBC #$08
	STA (EnemyPointX), y

	RTS
