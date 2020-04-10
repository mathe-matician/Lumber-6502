
	;; en 1 dest: y=C8 x=E0

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
	LDA EnBit
	AND #%00000010
	BNE BottomWallFlag_Marked
	LDA EnBit
	AND #%00000100
	BNE RightWallFlag_Marked
	LDA EnBit
	AND #%00001000
	BNE LeftWallFlag_Marked

	LDA EnCounter
	CLC
	ADC #$01
	STA EnCounter
	
	LDA EnCounter
	BNE DoneEn
	
	LDA EnCounter_Dec
	SEC
	SBC #$01
	STA EnCounter_Dec
	LDA EnCounter_Dec
	BEQ En1
DoneEn:
	JMP EnMovementDone

BottomWallFlag_Marked:
	JSR ReachedBottomWall
	JMP EnMovementDone
RightWallFlag_Marked:
	JSR TraverseRight
	JMP EnMovementDone
LeftWallFlag_Marked:
	JSR TraverseLeft
	JMP EnMovementDone

DoneEn2:
	Jmp EnMovementDone
En1:
	LDA #$03
	STA EnCounter_Dec
	LDA #$00
	STA EnCounter
	
	LDA En1_LocY
	STA temp_en_y_move
	LDA En1_LocX
	STA temp_en_x_move

Move_En1_Down:
	LDA En1_LocY
	CMP #BOTTOMWALL
	BNE En1Check
	JMP ReachedBottomWall

En1Check:
	;; random choice to go down or right - would be en1 dependent and not universal
	
	;; check down movment
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move

	;; TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	JSR Tile_Translate
	CMP #$04
	BEQ @MetTree
	CMP #$3B
	BEQ @MetRockShort

	LDA En1_LocY
	CLC
	ADC #$08
	STA En1_LocY
	
	JMP EnMovementDone
@MetRockShort:
	JMP MetRock
@MetTree:
	LDA En1_Tree_Count
	CLC
	ADC #$01
	STA En1_Tree_Count

	LDA En1_Tree_Count
	CMP #$10
	BNE Continue
	JSR BreakTree
	JMP EnMovementDone
Continue:
	LDA En1_LocY	
	STA temp_en_y_move
	LDA En1_LocX
	STA temp_en_x_move

	;; check right movement
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move
	;; TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	JSR Tile_Translate
	CMP #$04
	BEQ @MetTree2
	CMP #$3B
	BEQ @MetRockClose2

	LDA En1_LocX
	CLC
	ADC #$08
	STA En1_LocX
	JMP EnMovementDone
@MetRockClose2:
	JMP @Continue2
	JMP MetRock
@MetTree2:
	LDA En1_Tree_Count
	CLC
	ADC #$01
	STA En1_Tree_Count

	LDA En1_Tree_Count
	CMP #$10
	BNE @Continue2
	JSR BreakTree
	JMP EnMovementDone
@Continue2:
	
	LDA En1_LocY
	STA temp_en_y_move
	LDA En1_LocX
	STA temp_en_x_move

	;; check left movement
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move
	;; TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	JSR Tile_Translate
	CMP #$04
	BEQ @MetTree3
	CMP #$3B
	BEQ MetRock

	LDA En1_LocX
	SEC
	SBC #$08
	STA En1_LocX
	JMP EnMovementDone

@MetTree3:
	LDA En1_Tree_Count
	CLC
	ADC #$01
	STA En1_Tree_Count

	LDA En1_Tree_Count
	CMP #$10
	BNE @Continue3
	JSR BreakTree
	JMP EnMovementDone
@Continue3:
	JSR BreakTree
	JMP EnMovementDone
BackUp:
	JMP En1Check
	
MetRock:
	JMP Continue
	JMP EnMovementDone
	
TestRock:	
	CMP #$3B
	BEQ En1Done
	LDA En1_LocY
	CLC
	ADC #$08
	STA En1_LocY
	JMP EnMovementDone
TestTreeBreak:
	LDA En1_Tree_Count
	CMP #$10
	BNE En1Done
	JSR BreakTree
	JMP TestRock
En1Done:
	;; can possibly just use inc En1_Tree_Count
	;; LDA En1_Tree_Count
	;; CLC
	;; ADC #$01
	;; STA En1_Tree_Count

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

ReachedBottomWall:
	LDA #$02
	STA EnBit
OuterLoop:
	LDA En1_LocY
	CMP #TOPWALL
	BEQ TraverseRight
	
	LDA EnCounter2
	CLC
	ADC #$01
	STA EnCounter2
	
	LDA EnCounter2
	BNE BottomWallDone

	LDA EnCounter_Dec2
	SEC
	SBC #$01
	STA EnCounter_Dec2
	LDA EnCounter_Dec2
	BNE BottomWallDone
InnerLoop:
	LDA #$03
	STA EnCounter_Dec2
	LDA #$00
	STA EnCounter2
	
	LDA En1_LocY
	STA temp_en_y_move
	LDA En1_LocX
	STA temp_en_x_move

	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move

	;; TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	JSR Tile_Translate
	CMP #$04
	JSR BreakTree
	CMP #$3B
	BEQ TraverseRight

	;; en goes back up if reached bottom wall
	LDA En1_LocY
	SEC
	SBC #$08
	STA En1_LocY

BottomWallDone:
	rts
	
Flip_Bottom_Flag:
	LDA #$01
	STA EnBit
	rts
TraverseRight:
	LDA En1_LocX
	CMP #RIGHTWALL
	BEQ DONE
	
	LDA #%00000100
	STA EnBit
	
	LDA EnCounter3
	CLC
	ADC #$01
	STA EnCounter3
	
	LDA EnCounter3
	BNE DONE

	LDA EnCounter_Dec3
	SEC
	SBC #$01
	STA EnCounter_Dec3
	LDA EnCounter_Dec3
	BNE DONE
InnerLoop2:
	LDA #$02
	STA EnCounter_Dec3
	LDA #$00
	STA EnCounter3
	
	LDA En1_LocY
	STA temp_en_y_move
	LDA En1_LocX
	STA temp_en_x_move

	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	JSR Tile_Translate
	CMP #$04
	JSR BreakTree
	CMP #$3B
	BEQ FlipBottomFlag2
	
	LDA En1_LocX
	CLC
	ADC #$08
	STA En1_LocX

	LDA EnDec
	SEC
	SBC #$01
	STA EnDec
	LDA EnDec
	BEQ FlipBottomFlag2
DONE:	
	rts
FlipBottomFlag2:	
	LDA #$04
	STA EnDec
	
	LDA #$01
	STA EnBit
	rts

FlipLeftFlag:
	LDA #%00001000
	STA EnBit
	rts

TraverseLeft:
	
