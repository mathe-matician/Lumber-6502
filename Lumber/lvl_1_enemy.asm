EnAni:	
	DEC FrameCounter4
En1_Ani_1:
	LDA FrameCounter4
	CMP #$00
	BNE EnAni
	
	DEC FrameCounter3
	LDA FrameCounter3
	CMP #$00
	BNE En1_Ani_1

	DEC FrameCounter2
	LDA FrameCounter2
	CMP #$00
	BNE En1_Ani_1

En1_first:
	LDA enn
	CMP %00000001
	BNE En1_1
	
	LDX #$08
	PLA
	TAY
En1_1:	
	LDA Lvl_1_En1, y
	STA $021C
	INY
	DEX
	CPX #$00
	BEQ En1_Reset
	TYA
	PHA

	LDA %00000001
	STA enn

En1_Done:
	JMP Forever

En1_Reset:
	LDA %00000000
	STA enn
	
	
;; 	LDA FrameCounter4
;; 	CMP #$FF
;; 	BNE En1_walk_add4
;; En1_first:
;; 	LDA enn
;; 	CMP %00000001
;; 	BEQ En1_walk
	
;; 	LDY #$00
;; 	LDX #$0A
;; 	PLA
;; 	TAY
;; 	PLA
;; 	TAX
;; En1_walk:	
;; 	LDA Lvl_1_En1, y
;; 	STA $021C
;; 	INY
;; 	DEX
;; 	TXA
;; 	PHA
;; 	TYA
;; 	PHA

;; 	LDA %00000001
;; 	STA enn

;; En1_walk_add4:	
;; 	LDA FrameCounter4
;; 	CLC
;; 	ADC #$01
;; 	STA FrameCounter4

;; En1_walk_done:	
	;; JMP MoveEnDone

	

;; 	LDA FrameCounter4
;; 	CMP #$80
;; 	BEQ Enemy_1_init
;; 	JMP MoveEnDone

;; Enemy_1_init:
;; 	LDA $021C
;; 	STA temp_en_y_move
;; 	LDA $021F
;; 	STA temp_en_x_move

;; lvl1_enemy_1_up:

;; 	LDA $021C
;; 	CMP #TOPWALL
;; 	BEQ lvl1_enemy_1_up_done

;; 	LDA temp_en_y_move
;; 	SEC
;; 	SBC #$08
;; 	STA temp_en_y_move

;; 	LDA #$00
;; 	STA M
;; 	LDA temp_en_y_move
;; 	AND #%11111000
;; 	ASL
;; 	ROL M
;; 	ASL
;; 	ROL M
;; 	ADC #<background_lvl_1_1
;; 	STA Z
;; 	LDA M
;; 	ADC #>background_lvl_1_1
;; 	STA M
;; 	LDA temp_en_x_move
;; 	LSR
;; 	LSR
;; 	LSR			;divide by 8
;; 	TAY
	
;; 	LDA (Z), Y
;; 	STA fake_en_1
;; 	CMP #$04
;; 	BEQ lvl1_enemy_1_up_done
	
;; 	;; move enemy up if open space
;; 	LDA $021C
;; 	SEC
;; 	SBC #$08
;; 	STA $021C

;; 	LDA %00000001
;; 	STA en1_bitflag

;; lvl1_enemy_1_up_done:
;; 	;; JMP MoveEnDone

;; lvl1_enemy_1_down:
;; 		;; check if player has reached left wall
;; 	LDA $021C
;; 	CMP #BOTTOMWALL
;; 	BEQ lvl1_enemy_1_down_done

;; 	LDA temp_en_y_move
;; 	CLC
;; 	ADC #$08
;; 	STA temp_en_y_move

;; 	LDA #$00
;; 	STA M
;; 	LDA temp_en_y_move
;; 	AND #%11111000
;; 	ASL
;; 	ROL M
;; 	ASL
;; 	ROL M
;; 	ADC #<background_lvl_1_1
;; 	STA Z
;; 	LDA M
;; 	ADC #>background_lvl_1_1
;; 	STA M
;; 	LDA temp_en_x_move
;; 	LSR
;; 	LSR
;; 	LSR			;divide by 8
;; 	TAY
	
;; 	LDA (Z), Y
;; 	STA fake_en_1
;; 	CMP #$04
;; 	BEQ lvl1_enemy_1_down_done

;; 	;; move enemy up if open space
;; 	LDA $021C
;; 	CLC
;; 	ADC #$08
;; 	STA $021C

;; 	LDA %00000010
;; 	STA en1_bitflag

;; lvl1_enemy_1_down_done:
;; 	JMP MoveEnDone

;; lvl1_enemy_1_right:
;; 		;; check if player has reached left wall
;; 	LDA $021F
;; 	CMP #RIGHTWALL
;; 	BEQ lvl1_enemy_1_right_done

;; 	LDA temp_en_x_move
;; 	CLC
;; 	ADC #$08
;; 	STA temp_en_x_move

;; 	LDA #$00
;; 	STA M
;; 	LDA temp_en_y_move
;; 	AND #%11111000
;; 	ASL
;; 	ROL M
;; 	ASL
;; 	ROL M
;; 	ADC #<background_lvl_1_1
;; 	STA Z
;; 	LDA M
;; 	ADC #>background_lvl_1_1
;; 	STA M
;; 	LDA temp_en_x_move
;; 	LSR
;; 	LSR
;; 	LSR			;divide by 8
;; 	TAY
	
;; 	LDA (Z), Y
;; 	STA fake_en_1
;; 	CMP #$04
;; 	BEQ lvl1_enemy_1_right_done

;; 	;; move enemy up if open space
;; 	LDA $021F
;; 	CLC
;; 	ADC #$08
;; 	STA $021F

;; lvl1_enemy_1_right_done:

;; lvl1_enemy_1_left:
;; 		;; check if player has reached left wall
;; 	LDA $021F
;; 	CMP #LEFTWALL
;; 	BEQ lvl1_enemy_1_left_done

;; 	LDA temp_en_x_move
;; 	SEC
;; 	SBC #$08
;; 	STA temp_en_x_move

;; 	LDA #$00
;; 	STA M
;; 	LDA temp_en_y_move
;; 	AND #%11111000
;; 	ASL
;; 	ROL M
;; 	ASL
;; 	ROL M
;; 	ADC #<background_lvl_1_1
;; 	STA Z
;; 	LDA M
;; 	ADC #>background_lvl_1_1
;; 	STA M
;; 	LDA temp_en_x_move
;; 	LSR
;; 	LSR
;; 	LSR			;divide by 8
;; 	TAY
	
;; 	LDA (Z), Y
;; 	STA fake_en_1
;; 	CMP #$04
;; 	BEQ lvl1_enemy_1_left_done

;; 	;; move enemy up if open space
;; 	LDA $021F
;; 	SEC
;; 	SBC #$08
;; 	STA $021F

;; lvl1_enemy_1_left_done:

;; MoveEnDone:
