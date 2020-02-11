Control_State:	
	LDA STATE
	CMP #$00
	BEQ Start_Controls
	LDA STATE
	AND #%00000001
	BNE Game_Controls
	LDA STATE
	AND #%00000010
	BNE Gameover_Controls
	LDA STATE
	AND #%00000100
	BNE Text_Controls

	;; RTS
	JMP ControlsDone

	;; Set up Jump table instead of branches

Text_Controls:
	LDA buttons1
	AND #%10000000
	BEQ TextControlsDone	;could change to RTS

	LDA lvl1_npc_flags
	AND #%00000010
	BEQ TextControlsDone	;could change to RTS

	LDA #%00000100
	STA lvl1_npc_flags
	
	LDA #%00011110
	STA $2001

	LDA #$00
	STA FrameCounter1
	STA STATE
	LDA #%00000001
	STA STATE
	
TextControlsDone:
	;; RTS 			;should go back to UpdateController
	JMP ControlsDone

Gameover_Controls:
	JMP ControlsDone

Start_Controls:	
	LDA buttons1
	AND #%00010000
	BEQ Start_ControlsDone
	
	LDA #%00000001
	STA levels
	STA STATE

Start_ControlsDone:	
	JMP ControlsDone

Game_Controls:

	LDA FrameCounter1
	CMP #$06
	BEQ Start_Game_Controls
	JMP ControlsDone
	
Start_Game_Controls:
	LDA #$00
	STA FrameCounter1
	
	LDA shadow_oam
	STA temp_player_y_move

	LDA shadow_oam+3
	STA temp_player_x_move

MovePlayerUp:	
	LDA buttons1
	AND #%00001000
	BEQ MovePlayerUpDone

	LDA #%00001000
	STA playerfacing

MovingPlayerUp:
	LDA $0201
	CMP #$12
	BEQ WalkUp

	LDA #$12
	STA $0201
	JMP WalkUpDone

WalkUp:
	LDA #$23
	STA $0201

WalkUpDone:	
	
	;; check if player has reached left wall
	LDA $0200
	CMP #TOPWALL
	BEQ MovePlayerUpDone

	LDA temp_player_y_move
	SEC
	SBC #$08
	STA temp_player_y_move

	TileTranslate H, L, temp_player_y_move, temp_player_x_move, background_lvl_1_1
	STA fake_player
	CMP #$04
	BEQ MovePlayerUpDone	
	LDA fake_player
	CMP #$07
	BEQ SevenBlockUp

	;; move player up if open space
	LDA $0200
	SEC
	SBC #$08
	STA $0200
	JMP MovePlayerUpDone

SevenBlockUp:
	LDA #%00000001
	STA sevenblock
	
MovePlayerUpDone:

MovePlayerDown:
	LDA buttons1
	AND #%00000100
	BEQ MovePlayerDownDone

	LDA #%00000100
	STA playerfacing

MovingPlayerDown:
	
	LDA $0201
	CMP #$11
	BEQ WalkDown

	LDA #$11
	STA $0201
	JMP WalkDownDone
WalkDown:
	LDA #$22
	STA $0201

WalkDownDone:	

	;; check if player has reached bottom wall
	LDA $0200
	CMP #BOTTOMWALL
	BEQ MovePlayerDownDone

	LDA temp_player_y_move
	CLC
	ADC #$08
	STA temp_player_y_move

	TileTranslate H, L, temp_player_y_move, temp_player_x_move, background_lvl_1_1
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

	LDA #%00000001
	STA playerfacing

MovingPlayerRight:
	LDA $0201		;player sprite
	CMP #$03
	BEQ WalkRight
	
	LDA #$03
	STA $0201
	JMP WalkRightDone
	
WalkRight:	
	LDA #$13
	STA $0201

WalkRightDone:	

	;; check if player has reached right wall
	LDA $0203
	CMP #RIGHTWALL
	BEQ MovePlayerRightDone
	
	LDA temp_player_x_move
	CLC
	ADC #$08
	STA temp_player_x_move

	
	TileTranslate H, L, temp_player_y_move, temp_player_x_move, background_lvl_1_1
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

	LDA #%00000010
	STA playerfacing

MovingPlayerLeft:

	LDA $0201
	CMP #$04
	BEQ WalkLeft
	
	LDA #$04
	STA $0201
	JMP WalkLeftDone

WalkLeft:
	LDA #$14
	STA $0201

WalkLeftDone:	

	;; check if player has reached left wall
	LDA $0203
	CMP #LEFTWALL
	BEQ MovePlayerLeftDone
	
	LDA temp_player_x_move
	SEC
	SBC #$08
	STA temp_player_x_move

	TileTranslate H, L, temp_player_y_move, temp_player_x_move, background_lvl_1_1
	STA fake_player
	CMP #$04
	BEQ MovePlayerLeftDone
	CMP #$07
	BEQ SevenBlockLeft

	;; move player left if no collision
	LDA $0203
	SEC
	SBC #$08
	STA $0203
	JMP MovePlayerLeftDone
SevenBlockLeft:
	LDA #%00000010
	STA sevenblock
	
MovePlayerLeftDone:	

PlayerPunch:
	LDA buttons1
	AND #%01000000		;B button for bashin'
	BEQ PunchDone

	LDA playerfacing
	AND #%00001000
	BNE PunchUp

	LDA playerfacing
	AND #%00000100
	BNE PunchDown

	LDA $0201
	CMP #$04
	BEQ PunchLeft
	CMP #$14
	BEQ PunchLeft
	
	LDA playerfacing
	AND #%00000010
	BNE PunchLeft

	LDA $0201
	CMP #$03
	BEQ PunchRight
	CMP #$13
	BEQ PunchRight

	LDA playerfacing
	AND #%00000001
	BNE PunchRight
	
	JMP ControlsDone
	
PunchUp:
	LDA #$0A
	STA $0201
	JMP PunchDone

PunchDown:
	LDA #$09
	STA $0201
	JMP PunchDone

PunchLeft:
	LDA #$08
	STA $0201
	JMP PunchDone

PunchRight:
	LDA #$07
	STA $0201

PunchDone:

PlayerAction:
	LDA buttons1
	AND #%10000000		;A for Action
	BEQ BeDone
	
	;; LDA playerfacing
	;; AND #%00001000
	;; BNE ActionUp

	LDA $0201
	CMP #$12
	BEQ ActionUp
	LDA $0201
	CMP #$23
	BEQ ActionUp
	LDA $0201
	CMP #$02
	BEQ ActionUp

	LDA $0201
	CMP #$04
	BEQ ActionLeft
	LDA $0201
	CMP #$14
	BEQ ActionLeft

BeDone:	
	JMP PlayerActionDone
ActionUp:
	LDA sevenblock
	AND #%00000001
	BEQ PlayerActionDone

	LDA #$02
	STA $0202

	LDA #%00000001
	STA lvl1_npc_flags
	LDA #%00000100
	STA STATE
	;; LDA #$00
	;; STA sevenblock
	
	JMP PlayerActionDone
ActionLeft:
	LDA sevenblock
	AND #%00000010
	BEQ PlayerActionDone

	LDA #$01
	STA $0202
	LDA #%00010000		;temp
	STA lvl1_npc_flags
	LDA #$00
	STA sevenblock

PlayerActionDone:
	LDA #$00
	STA playerfacing
	
ControlsDone:	
