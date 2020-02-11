	LDA FrameCounter1
	CMP #$06
	BNE EnKeepGoing1
	JMP StartEn2Check
EnKeepGoing1: 
	CMP #$05
	BEQ StartEn1Check
	CMP #$04
	BNE EnKeepGoing2
	JMP StartEn3Check
EnKeepGoing2:	
	CMP #$03
	BNE En1Error
	JMP StartEn4Check

StartEn1Check:	
	LDA Lvl1_En1_Loc
	STA temp_en_y_move
	LDA Lvl1_En1_Loc+3
	STA temp_en_x_move

	PRNG seed	
	CMP #$40
	BCC MoveEn1UpCheck
	CMP #$80
	BCC MoveEn1DownCheck
	CMP #$C0
	BCC MoveEn1LeftCheck
	CMP #$FF
	BCS En1Error
	JMP MoveEn1RightCheck

En1Error:
	JMP MoveEnsDone

MoveEn1UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn1UpDone

	LDA Lvl1_En1_Loc
	SEC
	SBC #$08
	STA Lvl1_En1_Loc
	
MoveEn1UpDone:
	JMP MoveEnsDone

MoveEn1DownCheck:
	LDA Lvl1_En1_Loc
	CMP #$80
	BEQ MoveEn1DownDone
	
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn1DownDone

	LDA Lvl1_En1_Loc
	CLC
	ADC #$08
	STA Lvl1_En1_Loc

MoveEn1DownDone:
	JMP MoveEnsDone
	
MoveEn1LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn1LeftDone

	LDA Lvl1_En1_Loc+3
	SEC
	SBC #$08
	STA Lvl1_En1_Loc+3

MoveEn1LeftDone:
	JMP MoveEnsDone

MoveEn1RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn1RightDone

	LDA Lvl1_En1_Loc+3
	CLC
	ADC #$08
	STA Lvl1_En1_Loc+3

MoveEn1RightDone:
	JMP MoveEnsDone

StartEn2Check:	
	LDA Lvl1_En2_Loc
	STA temp_en_y_move
	LDA Lvl1_En2_Loc+3
	STA temp_en_x_move

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
	JMP MoveEnsDone

MoveEn2UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2UpDone

	LDA Lvl1_En2_Loc
	SEC
	SBC #$08
	STA Lvl1_En2_Loc
	
MoveEn2UpDone:
	JMP MoveEnsDone

MoveEn2DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2DownDone

	LDA Lvl1_En2_Loc
	CLC
	ADC #$08
	STA Lvl1_En2_Loc

MoveEn2DownDone:
	JMP MoveEnsDone
	
MoveEn2LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2LeftDone

	LDA Lvl1_En2_Loc+3
	SEC
	SBC #$08
	STA Lvl1_En2_Loc+3

MoveEn2LeftDone:
	JMP MoveEnsDone

MoveEn2RightCheck:
	LDA Lvl1_En2_Loc+3
	CMP #$70
	BEQ MoveEn2RightDone
	
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn2RightDone

	LDA Lvl1_En2_Loc+3
	CLC
	ADC #$08
	STA Lvl1_En2_Loc+3

MoveEn2RightDone:
	JMP MoveEnsDone

StartEn3Check:	
	LDA Lvl1_En3_Loc
	STA temp_en_y_move
	LDA Lvl1_En3_Loc+3
	STA temp_en_x_move

	PRNG seed	
	CMP #$40
	BCC MoveEn3UpCheck
	CMP #$80
	BCC MoveEn3DownCheck
	CMP #$C0
	BCC MoveEn3LeftCheck
	CMP #$FF
	BCS En3Error
	JMP MoveEn3RightCheck

En3Error:
	JMP MoveEnsDone

MoveEn3UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn3UpDone

	LDA Lvl1_En3_Loc
	SEC
	SBC #$08
	STA Lvl1_En3_Loc
	
MoveEn3UpDone:
	JMP MoveEnsDone

MoveEn3DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn3DownDone

	LDA Lvl1_En3_Loc
	CLC
	ADC #$08
	STA Lvl1_En3_Loc

MoveEn3DownDone:
	JMP MoveEnsDone
	
MoveEn3LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn3LeftDone

	LDA Lvl1_En3_Loc+3
	SEC
	SBC #$08
	STA Lvl1_En3_Loc+3

MoveEn3LeftDone:
	JMP MoveEnsDone

MoveEn3RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn3RightDone

	LDA Lvl1_En3_Loc+3
	CLC
	ADC #$08
	STA Lvl1_En3_Loc+3

MoveEn3RightDone:
	JMP MoveEnsDone

StartEn4Check:	
	LDA Lvl1_En4_Loc
	STA temp_en_y_move
	LDA Lvl1_En4_Loc+3
	STA temp_en_x_move

	PRNG seed	
	CMP #$40
	BCC MoveEn4UpCheck
	CMP #$80
	BCC MoveEn4DownCheck
	CMP #$C0
	BCC MoveEn4LeftCheck
	CMP #$FF
	BCS En4Error
	JMP MoveEn4RightCheck

En4Error:
	JMP MoveEnsDone

MoveEn4UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn4UpDone

	LDA Lvl1_En4_Loc
	SEC
	SBC #$08
	STA Lvl1_En4_Loc
	
MoveEn4UpDone:
	JMP MoveEnsDone

MoveEn4DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn4DownDone

	LDA Lvl1_En4_Loc
	CLC
	ADC #$08
	STA Lvl1_En4_Loc

MoveEn4DownDone:
	JMP MoveEnsDone
	
MoveEn4LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn4LeftDone

	LDA Lvl1_En4_Loc+3
	SEC
	SBC #$08
	STA Lvl1_En4_Loc+3

MoveEn4LeftDone:
	JMP MoveEnsDone

MoveEn4RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, background_lvl_1_1
	CMP #$04
	BEQ MoveEn4RightDone

	LDA Lvl1_En4_Loc+3
	CLC
	ADC #$08
	STA Lvl1_En4_Loc+3

MoveEn4RightDone:
	JMP MoveEnsDone

MoveEnsDone:	
