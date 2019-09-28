	LDA levels
	CMP #%00000001
	BEQ Level_1_Animations

	CMP #%00000010
	BEQ Level_2_Animations

	JMP AnimationsDone

;------------------------------------------------
;Level 1
;------------------------------------------------

Level_1_Animations:	
Gold_1_Loop:	
	DEC FrameCounter1

	LDA FrameCounter1
	CMP #$00
	BNE Gold_1_Loop

	DEX
	CPX #$00
	BNE Forever
Gold_1:	
	LDA $0228
	CMP #$A0
	BEQ Enemy1_1_1
	CLC
	ADC #$04
	STA $0228
	CMP #$A0
	BNE Next1
Enemy1_1_1:	
	LDA $022B
	CLC
	ADC #$04
	STA $022B
	CMP #$A0
	BNE Next1
Next1:	
	LDA $0215
	CMP #$20
	BNE Gold_1_Flip
	LDA #$21
	STA $0215
	JMP Gold_1_Done
Gold_1_Flip:	
	LDA #$20
	STA $0215
Gold_1_Done:	
	LDA #$FF
	STA FrameCounter1

	JMP Forever

;------------------------------------------------
;Level 2
;------------------------------------------------
	
Level_2_Animations:
	LDA #$10
	STA $0201

AnimationsDone:	
