MovePlayerUp:	
	LDA buttons1
	AND #%00001000
	BEQ MovePlayerUpDone

MovingPlayerUp:
	LDA #$02
	STA $0201	;character sprite facing away
	LDA $0200
	SEC
	SBC #$01
	STA $0200
	
MovePlayerUpDone:
	;; add both feet on ground sprite?

MovePlayerDown:
	LDA buttons1
	AND #%00000100
	BEQ MovePlayerDownDone

MovingPlayerDown:
	LDA #$01
	STA $0201
	LDA $0200
	CLC
	ADC #$01
	STA $0200

MovePlayerDownDone:
	;; add both feet on ground sprite?

MovePlayerRight:
	LDA buttons1
	AND #%00000001
	BEQ MovePlayerRightDone

MovingPlayerRight:
	LDA #$03
	STA $0201
	LDA $0203
	CLC
	ADC #$01
	STA $0203

MovePlayerRightDone:

MovePlayerLeft:
	LDA buttons1
	AND #%00000010
	BEQ MovePlayerLeftDone

MovingPlayerLeft:
	LDA #$04
	STA $0201
	LDA $0203
	SEC
	SBC #$01
	STA $0203

MovePlayerLeftDone:	

