
Enemy_Movement_Table:
	LDA enemy_num_tablecheck
	ASL
	TAX

	LDA En_Move_RTS_table+1, x
	PHA	;push high byte
	LDA En_Move_RTS_table, X
	PHA 	;push low byte
	RTS	;launches our subroutine indexed by enemy_num_tablecheck

	;; .include "fourens.asm"
four_ens:
	LDA EnCounter
	CMP #$40
	BNE Keepgoing4_1
	JMP StartEn2Check
Keepgoing4_1:
	CMP #$30
	BEQ StartEn1Check
	CMP #$20
	BNE Keepgoing4_2
	JMP StartEn3Check
Keepgoing4_2:
	CMP #$10
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
	BCC Close0
	CMP #$C0
	BCC Close1
	CMP #$FF
	BCC En1Error
	JMP MoveEn1RightCheck
Close0:
	jmp MoveEn1DownCheck
Close1:
	jmp MoveEn1LeftCheck
En1Error:
	JMP Move4EnsDone

MoveEn1UpCheck:
	LDA En1_LocY
	CMP #TOPWALL
	BEQ MoveEn1UpDone
	
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
	STA En1_LocY
	
MoveEn1UpDone:
	JMP Move4EnsDone

MoveEn1DownCheck:
	LDA En1_LocY
	CMP #BOTTOMWALL
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
	LDA En1_LocX
	CMP #LEFTWALL
	BEQ MoveEn1LeftDone
	
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
	LDA En1_LocX
	CMP #RIGHTWALL
	BEQ MoveEn1RightDone
	
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
	BCC En2Error
	JMP MoveEn2RightCheck
Close2:
	jmp MoveEn2DownCheck
Close3:
	jmp MoveEn2LeftCheck

En2Error:
	JMP Move4EnsDone

MoveEn2UpCheck:
	LDA En2_LocY
	CMP #TOPWALL
	BEQ MoveEn2UpDone
	
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
	LDA En2_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn2DownDone
	
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
	LDA En2_LocX
	CMP #LEFTWALL
	BEQ MoveEn2LeftDone
	
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
	CMP #RIGHTWALL
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
	BCC En3Error
	JMP MoveEn3RightCheck
Close4:
	jmp MoveEn3DownCheck
Close5:
	jmp MoveEn3LeftCheck

En3Error:
	JMP Move4EnsDone

MoveEn3UpCheck:
	LDA En3_LocY
	CMP #TOPWALL
	BEQ MoveEn3UpDone
	
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
	LDA En3_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn3DownDone
	
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
	LDA En3_LocX
	CMP #LEFTWALL
	BEQ MoveEn3LeftDone
	
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
	LDA En3_LocX
	CMP #RIGHTWALL
	BEQ MoveEn3RightDone
	
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
	BCC En4Error
	JMP MoveEn4RightCheck
Close6:
	jmp MoveEn4DownCheck
Close7:
	jmp MoveEn4LeftCheck

En4Error:
	JMP Move4EnsDone

MoveEn4UpCheck:
	LDA En4_LocY
	CMP #TOPWALL
	BEQ MoveEn4UpDone
	
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
	LDA En4_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn4DownDone
	
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
	LDA En4_LocX
	CMP #LEFTWALL
	BEQ MoveEn4LeftDone
	
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
	LDA En4_LocX
	CMP #RIGHTWALL
	BEQ MoveEn4RightDone

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
	CMP #$10
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
	BCC Close8
	CMP #$C0
	BCC Close9
	CMP #$FF
	BCC En5Error
	JMP MoveEn5RightCheck
	
Close8:
	jmp MoveEn5DownCheck
Close9:
	jmp MoveEn5LeftCheck
	
En5Error:
	JMP Move5EnsDone

MoveEn5UpCheck:
	LDA En5_LocY
	CMP #TOPWALL
	BEQ MoveEn5UpDone
	
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
	LDA En5_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn5DownDone
	
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
	LDA En5_LocX
	CMP #LEFTWALL
	BEQ MoveEn5LeftDone

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
	LDA En5_LocX
	CMP #RIGHTWALL
	BEQ MoveEn5RightDone
	
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
	BCC En6Error
	JMP MoveEn6RightCheck

Close10:
	jmp MoveEn6DownCheck
Close11:
	jmp MoveEn6LeftCheck

En6Error:
	JMP Move6EnsDone

MoveEn6UpCheck:
	LDA En6_LocY
	CMP #TOPWALL
	BEQ MoveEn6UpDone
	
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
	LDA En6_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn6DownDone
	
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
	LDA En6_LocX
	CMP #LEFTWALL
	BEQ MoveEn6LeftDone

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
	LDA En6_LocX
	CMP #RIGHTWALL
	BEQ MoveEn6RightDone

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
	BCC En7Error
	JMP MoveEn7RightCheck

Close12:
	jmp MoveEn7DownCheck
Close13:
	jmp MoveEn7LeftCheck

En7Error:
	JMP Move7EnsDone

MoveEn7UpCheck:
	LDA En7_LocY
	CMP #TOPWALL
	BEQ MoveEn7UpDone
	
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
	LDA En7_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn7DownDone

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
	LDA En7_LocX
	CMP #LEFTWALL
	BEQ MoveEn7LeftDone
	
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
	LDA En7_LocX
	CMP #RIGHTWALL
	BEQ MoveEn7RightDone

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
	BCC En8Error
	JMP MoveEn8RightCheck

Close14:
	jmp MoveEn8DownCheck
Close15:
	jmp MoveEn8LeftCheck

En8Error:
	JMP Move8EnsDone

MoveEn8UpCheck:
	LDA En8_LocY
	CMP #TOPWALL
	BEQ MoveEn8UpDone
	
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
	LDA En8_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn8DownDone
	
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
	LDA En8_LocX
	CMP #LEFTWALL
	BEQ MoveEn8LeftDone

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
	LDA En8_LocX
	CMP #RIGHTWALL
	BEQ MoveEn8RightDone

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
	CMP #$9F
	BNE En9Error
	
StartEn9Check:	
	LDA En9_LocY
	STA temp_en_y_move
	LDA En9_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn9UpCheck
	CMP #$80
	BCC Close20
	CMP #$C0
	BCC Close21
	CMP #$FF
	BCC En9Error
	JMP MoveEn9RightCheck
Close20:
	jmp MoveEn9DownCheck
Close21:
	jmp MoveEn9LeftCheck

En9Error:
	JMP Move9EnsDone

MoveEn9UpCheck:
	LDA En9_LocY
	CMP #TOPWALL
	BEQ MoveEn9UpDone
	
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn9UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn9UpDone

	LDA En9_LocY
	SEC
	SBC #$08
	STA En9_LocY
	
MoveEn9UpDone:
	JMP Move9EnsDone

MoveEn9DownCheck:
	LDA En9_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn9DownDone
	
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn9DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn9DownDone

	LDA En9_LocY
	CLC
	ADC #$08
	STA En9_LocY

MoveEn9DownDone:
	JMP Move9EnsDone
	
MoveEn9LeftCheck:
	LDA En9_LocX
	CMP #LEFTWALL
	BEQ MoveEn9LeftDone

	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn9LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn9LeftDone

	LDA En9_LocX
	SEC
	SBC #$08
	STA En9_LocX

MoveEn9LeftDone:
	JMP Move9EnsDone

MoveEn9RightCheck:
	LDA En9_LocX
	CMP #RIGHTWALL
	BEQ MoveEn9RightDone

	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn9RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn9RightDone

	LDA En9_LocX
	CLC
	ADC #$08
	STA En9_LocX

MoveEn9RightDone:

Move9EnsDone:

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
	BCC En10Error
	JMP MoveEn10RightCheck
Close16:
	jmp MoveEn10DownCheck
Close17:
	jmp MoveEn10LeftCheck

En10Error:
	JMP Move10EnsDone

MoveEn10UpCheck:
	LDA En10_LocY
	CMP #TOPWALL
	BEQ MoveEn10UpDone
	
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
	LDA En10_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn10DownDone
	
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
	LDA En10_LocX
	CMP #LEFTWALL
	BEQ MoveEn10LeftDone

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
	LDA En10_LocX
	CMP #RIGHTWALL
	BEQ MoveEn10RightDone

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
	CMP #$AF
	BNE En11Error
	
StartEn11Check:	
	LDA En11_LocY
	STA temp_en_y_move
	LDA En11_LocX
	STA temp_en_x_move

	PRNG seed3	
	CMP #$40
	BCC MoveEn11UpCheck
	CMP #$80
	BCC Close22
	CMP #$C0
	BCC Close23
	CMP #$FF
	BCC En11Error
	JMP MoveEn11RightCheck
Close22:
	jmp MoveEn11DownCheck
Close23:
	jmp MoveEn11LeftCheck

En11Error:
	JMP Move11EnsDone

MoveEn11UpCheck:
	LDA En11_LocY
	CMP #TOPWALL
	BEQ MoveEn11UpDone
	
	LDA temp_en_y_move
	SEC
	SBC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn11UpDone
	CMP #$3B			;is rock?
	BEQ MoveEn11UpDone

	LDA En11_LocY
	SEC
	SBC #$08
	STA En11_LocY
	
MoveEn11UpDone:
	JMP Move11EnsDone

MoveEn11DownCheck:
	LDA En11_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn11DownDone
	
	LDA temp_en_y_move
	CLC
	ADC #$08
	STA temp_en_y_move
	
	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn11DownDone
	CMP #$3B			;is rock?
	BEQ MoveEn11DownDone

	LDA En11_LocY
	CLC
	ADC #$08
	STA En11_LocY

MoveEn11DownDone:
	JMP Move11EnsDone
	
MoveEn11LeftCheck:
	LDA En11_LocX
	CMP #LEFTWALL
	BEQ MoveEn11LeftDone

	LDA temp_en_x_move
	SEC
	SBC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn11LeftDone
	CMP #$3B			;is rock?
	BEQ MoveEn11LeftDone

	LDA En11_LocX
	SEC
	SBC #$08
	STA En11_LocX

MoveEn11LeftDone:
	JMP Move11EnsDone

MoveEn11RightCheck:
	LDA En11_LocX
	CMP #RIGHTWALL
	BEQ MoveEn11RightDone

	LDA temp_en_x_move
	CLC
	ADC #$08
	STA temp_en_x_move

	TileTranslate Z, M, temp_en_y_move, temp_en_x_move, $6000
	CMP #$04
	BEQ MoveEn11RightDone
	CMP #$3B			;is rock?
	BEQ MoveEn11RightDone

	LDA En11_LocX
	CLC
	ADC #$08
	STA En11_LocX

MoveEn11RightDone:

Move11EnsDone:

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
	BCC En12Error
	JMP MoveEn12RightCheck
Close18:
	jmp MoveEn12DownCheck
Close19:
	jmp MoveEn12LeftCheck

En12Error:
	JMP Move12EnsDone

MoveEn12UpCheck:
	LDA En12_LocY
	CMP #TOPWALL
	BEQ MoveEn12UpDone
	
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
	LDA En12_LocY
	CMP #BOTTOMWALL
	BEQ MoveEn12DownDone
	
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
	LDA En12_LocX
	CMP #LEFTWALL
	BEQ MoveEn12LeftDone

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
	LDA En12_LocX
	CMP #RIGHTWALL
	BEQ MoveEn12RightDone

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
