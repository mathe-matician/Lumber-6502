	LDA shadow_oam
	STA temp_player_y_move

	LDA shadow_oam+3
	STA temp_player_x_move

MovePlayerUp:	
	LDA buttons1
	AND #%00001000
	BEQ MovePlayerUpDone

MovingPlayerUp:
	LDA #$02
	STA $0201	;character sprite facing away
	
	;; check if player has reached left wall
	LDA $0200
	CMP #TOPWALL
	BEQ MovePlayerUpDone

	LDA temp_player_y_move
	SEC
	SBC #$08
	STA temp_player_y_move

	LDA #$00
	STA L
	LDA temp_player_y_move
	AND #%11111000
	ASL
	ROL L
	ASL
	ROL L
	ADC #<background_lvl_1_1
	STA H
	LDA L
	ADC #>background_lvl_1_1
	STA L
	LDA temp_player_x_move	;should be shadow_oam+3 current location
	LSR
	LSR
	LSR			;divide by 8
	TAY
	
	LDA (H), Y
	STA fake_player
	CMP #$04
	BEQ MovePlayerUpDone

	;; move player up if open space
	LDA $0200
	SEC
	SBC #$08
	STA $0200
	JMP MovePlayerUpDone
	
MovePlayerUpDone:

MovePlayerDown:
	LDA buttons1
	AND #%00000100
	BEQ MovePlayerDownDone

MovingPlayerDown:
	LDA #$01
	STA $0201

	;; check if player has reached bottom wall
	LDA $0200
	CMP #BOTTOMWALL
	BEQ MovePlayerDownDone

	LDA temp_player_y_move
	CLC
	ADC #$08
	STA temp_player_y_move

	LDA #$00
	STA L
	LDA temp_player_y_move
	AND #%11111000
	ASL
	ROL L
	ASL
	ROL L
	ADC #<background_lvl_1_1
	STA H
	LDA L
	ADC #>background_lvl_1_1
	STA L
	LDA temp_player_x_move	;should be shadow_oam+3 current location
	LSR
	LSR
	LSR			;divide by 8
	TAY
	
	LDA (H), Y
	STA fake_player
	CMP #$04
	BEQ MovePlayerDownDone

	;; move player down if no collision
	LDA $0200
	CLC
	ADC #$08
	STA $0200
	JMP MovePlayerDownDone

MovePlayerDownDone:

MovePlayerRight:
	LDA buttons1
	AND #%00000001
	BEQ MovePlayerRightDone

MovingPlayerRight:
	LDA #$03
	STA $0201

	;; check if player has reached right wall
	LDA $0203
	CMP #RIGHTWALL
	BEQ MovePlayerRightDone
	
	LDA temp_player_x_move
	CLC
	ADC #$08
	STA temp_player_x_move

	LDA #$00
	STA L
	LDA temp_player_y_move
	AND #%11111000
	ASL
	ROL L
	ASL
	ROL L
	ADC #<background_lvl_1_1
	STA H
	LDA L
	ADC #>background_lvl_1_1
	STA L
	LDA temp_player_x_move	;should be shadow_oam+3 current location
	LSR
	LSR
	LSR			;divide by 8
	TAY
	
	LDA (H), Y
	STA fake_player
	CMP #$04
	BEQ MovePlayerRightDone

	;; move player right if no collision
	LDA $0203
	CLC
	ADC #$08
	STA $0203
	JMP MovePlayerRightDone

MovePlayerRightDone:

MovePlayerLeft:
	LDA buttons1
	AND #%00000010
	BEQ MovePlayerLeftDone

MovingPlayerLeft:
	LDA #$04
	STA $0201

	;; check if player has reached left wall
	LDA $0203
	CMP #LEFTWALL
	BEQ MovePlayerLeftDone

	LDA temp_player_x_move
	SEC
	SBC #$08
	STA temp_player_x_move

	LDA #$00
	STA L
	LDA temp_player_y_move
	AND #%11111000
	ASL
	ROL L
	ASL
	ROL L
	ADC #<background_lvl_1_1
	STA H
	LDA L
	ADC #>background_lvl_1_1
	STA L
	LDA temp_player_x_move	;should be shadow_oam+3 current location
	LSR
	LSR
	LSR			;divide by 8
	TAY
	
	LDA (H), Y
	STA fake_player
	CMP #$04
	BEQ MovePlayerLeftDone

	;; move player left if no collision
	LDA $0203
	SEC
	SBC #$08
	STA $0203
	JMP MovePlayerLeftDone

MovePlayerLeftDone:	

