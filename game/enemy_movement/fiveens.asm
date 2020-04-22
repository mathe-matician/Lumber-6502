five_ens:
	LDA EnCounter
	CMP #$50
	BNE Keepgoing4_1
	JMP StartEn2Check
Keepgoing4_1:
	CMP #$40
	BEQ StartEn1Check
	CMP #$30
	BNE Keepgoing4_2
	JMP StartEn3Check
Keepgoing4_2:
	CMP #$20
	BNE En1Error
	JMP StartEn4Check
	
StartEn1Check:	
	LDA En1_LocY
	STA temp_en_y_move
	LDA En1_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn1UpCheck
	CMP #$80
	;; BCC MoveEn1DownCheck
	BCC Close0
	CMP #$C0
	;; BCC MoveEn1LeftCheck
	BCC Close1
	CMP #$FF
	BCS En1Error
	JMP MoveEn1RightCheck
Close0:
	jmp MoveEn1DownCheck
Close1:
	jmp MoveEn1LeftCheck
En1Error:
	JMP Move4EnsDone

MoveEn1UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn1UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn1UpDone

	LDA En1_LocY
	SEC
	SBC #$08
	STA En1_LocX
	
MoveEn1UpDone:
	JMP Move4EnsDone

MoveEn1DownCheck:
	LDA En1_LocY
	CMP #$80
	BEQ MoveEn1DownDone
	
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn1DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn1DownDone

	LDA En1_LocY
	CLC
	ADC #$08
	STA En1_LocY

MoveEn1DownDone:
	JMP Move4EnsDone
	
MoveEn1LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn1LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn1LeftDone

	LDA En1_LocX
	SEC
	SBC #$08
	STA En1_LocX

MoveEn1LeftDone:
	JMP Move4EnsDone

MoveEn1RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn1RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn1RightDone

	LDA En1_LocX
	CLC
	ADC #$08
	STA En1_LocX

MoveEn1RightDone:
	JMP Move4EnsDone

StartEn2Check:	
	LDA En2_LocY
	STA temp_en_y_move
	LDA En2_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn2UpCheck
	CMP #$80
	;; BCC MoveEn2DownCheck
	BCC Close2
	CMP #$C0
	;; BCC MoveEn2LeftCheck
	BCC Close3
	CMP #$FF
	BCS En2Error
	JMP MoveEn2RightCheck
Close2:
	jmp MoveEn2DownCheck
Close3:
	jmp MoveEn2LeftCheck

En2Error:
	JMP Move4EnsDone

MoveEn2UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn2UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn2UpDone

	LDA En2_LocY
	SEC
	SBC #$08
	STA En2_LocY
	
MoveEn2UpDone:
	JMP Move4EnsDone

MoveEn2DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn2DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn2DownDone

	LDA En2_LocY
	CLC
	ADC #$08
	STA En2_LocY

MoveEn2DownDone:
	JMP Move4EnsDone
	
MoveEn2LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn2LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn2LeftDone

	LDA En2_LocX
	SEC
	SBC #$08
	STA En2_LocX

MoveEn2LeftDone:
	JMP Move4EnsDone

MoveEn2RightCheck:
	LDA En2_LocX
	CMP #$70
	BEQ MoveEn2RightDone
	
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn2RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn2RightDone

	LDA En2_LocX
	CLC
	ADC #$08
	STA En2_LocX

MoveEn2RightDone:
	JMP Move4EnsDone

StartEn3Check:	
	LDA En3_LocY
	STA temp_en_y_move
	LDA En3_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn3UpCheck
	CMP #$80
	;; BCC MoveEn3DownCheck
	BCC Close4
	CMP #$C0
	;; BCC MoveEn3LeftCheck
	BCC Close5
	CMP #$FF
	BCS En3Error
	JMP MoveEn3RightCheck
Close4:
	jmp MoveEn3DownCheck
Close5:
	jmp MoveEn3LeftCheck

En3Error:
	JMP Move4EnsDone

MoveEn3UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn3UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn3UpDone

	LDA En3_LocY
	SEC
	SBC #$08
	STA En3_LocY
	
MoveEn3UpDone:
	JMP Move4EnsDone

MoveEn3DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn3DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn3DownDone

	LDA En3_LocY
	CLC
	ADC #$08
	STA En3_LocY

MoveEn3DownDone:
	JMP Move4EnsDone
	
MoveEn3LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn3LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn3LeftDone

	LDA En3_LocX
	SEC
	SBC #$08
	STA En3_LocX

MoveEn3LeftDone:
	JMP Move4EnsDone

MoveEn3RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn3RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn3RightDone

	LDA En3_LocX
	CLC
	ADC #$08
	STA En3_LocX

MoveEn3RightDone:
	JMP Move4EnsDone

StartEn4Check:	
	LDA En4_LocY
	STA temp_en_y_move
	LDA En4_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn4UpCheck
	CMP #$80
	;; BCC MoveEn4DownCheck
	BCC Close6
	CMP #$C0
	;; BCC MoveEn4LeftCheck
	BCC Close7
	CMP #$FF
	BCS En4Error
	JMP MoveEn4RightCheck
Close6:
	jmp MoveEn4DownCheck
Close7:
	jmp MoveEn4LeftCheck

En4Error:
	JMP Move4EnsDone

MoveEn4UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn4UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn4UpDone

	LDA En4_LocY
	SEC
	SBC #$08
	STA En4_LocY
	
MoveEn4UpDone:
	JMP Move4EnsDone

MoveEn4DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn4DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn4DownDone

	LDA En4_LocY
	CLC
	ADC #$08
	STA En4_LocY

MoveEn4DownDone:
	JMP Move4EnsDone
	
MoveEn4LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn4LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn4LeftDone

	LDA En4_LocX
	SEC
	SBC #$08
	STA En4_LocX

MoveEn4LeftDone:
	JMP Move4EnsDone

MoveEn4RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn4RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn4RightDone

	LDA En4_LocX
	CLC
	ADC #$08
	STA En4_LocX

MoveEn4RightDone:

Move4EnsDone:
	;; JSR four_ens

	LDA EnCounter
	CMP #$60
	BNE En5Error

StartEn5Check:	
	LDA En5_LocY
	STA temp_en_y_move
	LDA En5_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn5UpCheck
	CMP #$80
	;; BCC MoveEn5DownCheck
	BCC Close8
	CMP #$C0
	;; BCC MoveEn5LeftCheck
	BCC Close9
	CMP #$FF
	BCS En5Error
	JMP MoveEn5RightCheck
Close8:
	jmp MoveEn5DownCheck
Close9:
	jmp MoveEn5LeftCheck
	
En5Error:
	JMP Move5EnsDone

MoveEn5UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn5UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn5UpDone

	LDA En5_LocY
	SEC
	SBC #$08
	STA En5_LocY
	
MoveEn5UpDone:
	JMP Move5EnsDone

MoveEn5DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn5DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn5DownDone

	LDA En5_LocY
	CLC
	ADC #$08
	STA En5_LocY

MoveEn5DownDone:
	JMP Move5EnsDone
	
MoveEn5LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn5LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn5LeftDone

	LDA En5_LocX
	SEC
	SBC #$08
	STA En5_LocX

MoveEn5LeftDone:
	JMP Move5EnsDone

MoveEn5RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn5RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn5RightDone

	LDA En5_LocX
	CLC
	ADC #$08
	STA En5_LocX

MoveEn5RightDone:

Move5EnsDone:	
	rts
