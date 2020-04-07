
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
	rts
five_ens:
	JSR four_ens

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

six_ens:
	JSR four_ens
	JSR five_ens

	LDA EnCounter
	CMP #$70
	BNE En6Error

StartEn6Check:	
	LDA En6_LocY
	STA temp_en_y_move
	LDA En6_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn6UpCheck
	CMP #$80
	;; BCC MoveEn6DownCheck
	BCC Close10
	CMP #$C0
	;; BCC MoveEn6LeftCheck
	BCC Close11
	CMP #$FF
	BCS En6Error
	JMP MoveEn6RightCheck

Close10:
	jmp MoveEn6DownCheck
Close11:
	jmp MoveEn6LeftCheck

En6Error:
	JMP Move6EnsDone

MoveEn6UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn6UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn6UpDone

	LDA En6_LocY
	SEC
	SBC #$08
	STA En6_LocY
	
MoveEn6UpDone:
	JMP Move6EnsDone

MoveEn6DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn6DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn6DownDone

	LDA En6_LocY
	CLC
	ADC #$08
	STA En6_LocY

MoveEn6DownDone:
	JMP Move6EnsDone
	
MoveEn6LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn6LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn6LeftDone

	LDA En6_LocX
	SEC
	SBC #$08
	STA En6_LocX

MoveEn6LeftDone:
	JMP Move6EnsDone

MoveEn6RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn6RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn6RightDone

	LDA En6_LocX
	CLC
	ADC #$08
	STA En6_LocX

MoveEn6RightDone:

Move6EnsDone:	
	rts

seven_ens:
	JSR four_ens
	JSR five_ens
	JSR six_ens

	LDA EnCounter
	CMP #$80
	BNE En7Error

StartEn7Check:	
	LDA En7_LocY
	STA temp_en_y_move
	LDA En7_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn7UpCheck
	CMP #$80
	;; BCC MoveEn7DownCheck
	BCC Close12
	CMP #$C0
	;; BCC MoveEn7LeftCheck
	BCC Close13
	CMP #$FF
	BCS En7Error
	JMP MoveEn7RightCheck

Close12:
	jmp MoveEn7DownCheck
Close13:
	jmp MoveEn7LeftCheck

En7Error:
	JMP Move7EnsDone

MoveEn7UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn7UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn7UpDone

	LDA En7_LocY
	SEC
	SBC #$08
	STA En7_LocY
	
MoveEn7UpDone:
	JMP Move7EnsDone

MoveEn7DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn7DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn7DownDone

	LDA En7_LocY
	CLC
	ADC #$08
	STA En7_LocY

MoveEn7DownDone:
	JMP Move7EnsDone
	
MoveEn7LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn7LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn7LeftDone

	LDA En7_LocX
	SEC
	SBC #$08
	STA En7_LocX

MoveEn7LeftDone:
	JMP Move7EnsDone

MoveEn7RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn7RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn7RightDone

	LDA En7_LocX
	CLC
	ADC #$08
	STA En7_LocX

MoveEn7RightDone:

Move7EnsDone:
	rts

eight_ens:
	JSR four_ens
	JSR five_ens
	JSR six_ens
	JSR seven_ens

	LDA EnCounter
	CMP #$90
	BNE En8Error

StartEn8Check:	
	LDA En8_LocY
	STA temp_en_y_move
	LDA En8_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn8UpCheck
	CMP #$80
	;; BCC MoveEn8DownCheck
	BCC Close14
	CMP #$C0
	;; BCC MoveEn8LeftCheck
	BCC Close15
	CMP #$FF
	BCS En8Error
	JMP MoveEn8RightCheck

Close14:
	jmp MoveEn8DownCheck
Close15:
	jmp MoveEn8LeftCheck

En8Error:
	JMP Move8EnsDone

MoveEn8UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn8UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn8UpDone

	LDA En8_LocY
	SEC
	SBC #$08
	STA En8_LocY
	
MoveEn8UpDone:
	JMP Move8EnsDone

MoveEn8DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn8DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn8DownDone

	LDA En8_LocY
	CLC
	ADC #$08
	STA En8_LocY

MoveEn8DownDone:
	JMP Move8EnsDone
	
MoveEn8LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn8LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn8LeftDone

	LDA En8_LocX
	SEC
	SBC #$08
	STA En8_LocX

MoveEn8LeftDone:
	JMP Move8EnsDone

MoveEn8RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn8RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn8RightDone

	LDA En8_LocX
	CLC
	ADC #$08
	STA En8_LocX

MoveEn8RightDone:

Move8EnsDone:
	rts

ten_ens:
	JSR four_ens
	JSR five_ens
	JSR six_ens
	JSR seven_ens
	JSR eight_ens

	LDA EnCounter
	CMP #$A0
	BNE En10Error
	
StartEn10Check:	
	LDA En10_LocY
	STA temp_en_y_move
	LDA En10_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn10UpCheck
	CMP #$80
	;; BCC MoveEn10DownCheck
	BCC Close16
	CMP #$C0
	;; BCC MoveEn10LeftCheck
	BCC Close17
	CMP #$FF
	BCS En10Error
	JMP MoveEn10RightCheck
Close16:
	jmp MoveEn10DownCheck
Close17:
	jmp MoveEn10LeftCheck

En10Error:
	JMP Move10EnsDone

MoveEn10UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn10UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn10UpDone

	LDA En10_LocY
	SEC
	SBC #$08
	STA En10_LocY
	
MoveEn10UpDone:
	JMP Move10EnsDone

MoveEn10DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn10DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn10DownDone

	LDA En10_LocY
	CLC
	ADC #$08
	STA En10_LocY

MoveEn10DownDone:
	JMP Move10EnsDone
	
MoveEn10LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn10LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn10LeftDone

	LDA En10_LocX
	SEC
	SBC #$08
	STA En10_LocX

MoveEn10LeftDone:
	JMP Move10EnsDone

MoveEn10RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn10RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn10RightDone

	LDA En10_LocX
	CLC
	ADC #$08
	STA En10_LocX

MoveEn10RightDone:

Move10EnsDone:
	rts

twelve_ens:
	JSR four_ens
	JSR five_ens
	JSR six_ens
	JSR seven_ens
	JSR eight_ens
	JSR ten_ens

	LDA EnCounter
	CMP #$B0
	BNE En12Error
	
StartEn12Check:	
	LDA En12_LocY
	STA temp_en_y_move
	LDA En12_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn12UpCheck
	CMP #$80
	;; BCC MoveEn12DownCheck
	BCC Close18
	CMP #$C0
	;; BCC MoveEn12LeftCheck
	BCC Close19
	CMP #$FF
	BCS En12Error
	JMP MoveEn12RightCheck
Close18:
	jmp MoveEn12DownCheck
Close19:
	jmp MoveEn12LeftCheck

En12Error:
	JMP Move12EnsDone

MoveEn12UpCheck:
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn12UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn12UpDone

	LDA En12_LocY
	SEC
	SBC #$08
	STA En12_LocY
	
MoveEn12UpDone:
	JMP Move12EnsDone

MoveEn12DownCheck:
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn12DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn12DownDone

	LDA En12_LocY
	CLC
	ADC #$08
	STA En12_LocY

MoveEn12DownDone:
	JMP Move12EnsDone
	
MoveEn12LeftCheck:
	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn12LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn12LeftDone

	LDA En12_LocX
	SEC
	SBC #$08
	STA En12_LocX

MoveEn12LeftDone:
	JMP Move12EnsDone

MoveEn12RightCheck:
	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn12RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn12RightDone

	LDA En12_LocX
	CLC
	ADC #$08
	STA En12_LocX

MoveEn12RightDone:

Move12EnsDone:
	rts

MoveEnsDone:	
