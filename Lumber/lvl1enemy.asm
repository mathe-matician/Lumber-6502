	LDA FrameCounter1
	CMP #$06
	BEQ StartEn2Check
	JMP MoveEn2Done

StartEn2Check:	
	LDA Lvl1_En2_Loc
	STA temp_en2_y_move
	LDA Lvl1_En2_Loc+3
	STA temp_en2_x_move

	PRNG seed	
	CMP #$40
	BCC MoveEn2UpCheck
	CMP #$80
	BCC MoveEn2DownCheck
	CMP #$C0
	BCC MoveEn2LeftCheck
	CMP #$FF
	BCS En2Error
	JMP MoveEn2RightCheck

En2Error:
	JMP MoveEn2Done

MoveEn2UpCheck:
	LDA temp_en2_y_move
	SEC
	SBC #$08
	STA temp_en2_y_move
	
	TileTranslate Z, M, temp_en2_y_move, temp_en2_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2UpDone

	LDA Lvl1_En2_Loc
	SEC
	SBC #$08
	STA Lvl1_En2_Loc		

MoveEn2UpDone:
	JMP MoveEn2Done

MoveEn2DownCheck:
	LDA temp_en2_y_move
	CLC
	ADC #$08
	STA temp_en2_y_move
	
	TileTranslate Z, M, temp_en2_y_move, temp_en2_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2DownDone

	LDA Lvl1_En2_Loc
	CLC
	ADC #$08
	STA Lvl1_En2_Loc

MoveEn2DownDone:
	JMP MoveEn2Done
	
MoveEn2LeftCheck:
	LDA temp_en2_x_move
	SEC
	SBC #$08
	STA temp_en2_x_move

	TileTranslate Z, M, temp_en2_y_move, temp_en2_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2LeftDone

	LDA Lvl1_En2_Loc+3
	SEC
	SBC #$08
	STA Lvl1_En2_Loc+3

MoveEn2LeftDone:
	JMP MoveEn2Done

MoveEn2RightCheck:
	LDA temp_en2_x_move
	CLC
	ADC #$08
	STA temp_en2_x_move

	TileTranslate Z, M, temp_en2_y_move, temp_en2_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2RightDone

	LDA Lvl1_En2_Loc+3
	CLC
	ADC #$08
	STA Lvl1_En2_Loc+3

MoveEn2RightDone:

MoveEn2Done:	
	LDA seed
	CLC
	ADC #$03
	STA seed
