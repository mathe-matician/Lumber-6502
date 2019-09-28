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
	LDA Level_1_Enemies
	CMP #$01
	BNE Enemy1_Neg
Enemy1_Pos:	
	LDA $0228		;y-position
	CMP #$A0
	BEQ Enemy1_1_1
	CLC
	ADC #$08
	STA $0228
	JMP Next1
Enemy1_1_1:	
	LDA $022B		;x-position
	CMP #$A0
	BEQ Enemy1_1_2
	CLC
	ADC #$08
	STA $022B
	JMP Next1
Enemy1_1_2:
	LDA #$02
	STA Level_1_Enemies
Enemy1_Neg:
	LDA $0228
	CMP #$80
	BEQ Enemy1_1_3
	SEC
	SBC #$08
	STA $0228
	JMP Next1
Enemy1_1_3:
	LDA $022B
	SEC
	SBC #$08
	STA $022B
	CMP #$80
	BNE Next1
	LDA #$01
	STA Level_1_Enemies
	
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
