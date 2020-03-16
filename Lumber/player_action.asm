PlayerPunch:
	LDA new_button
	;; LDA buttons1
	AND #%01000000		;B button for bashin'
	BEQ PuncherDone

	LDA playerfacing
	AND #%00001000
	BNE PunchUp

	LDA playerfacing
	AND #%00000100
	BNE PunchDown
	
	LDA playerfacing
	AND #%00000010
	BNE PuncherLeft

	LDA playerfacing
	AND #%00000001
	BNE PuncherRight
	
	JMP PlayerActionDone
PuncherDone:
	JMP PunchDone
PuncherRight:
	JMP PunchRight
PuncherLeft:
	JMP PunchLeft
	
PunchUp:
	LDA #$0A
	STA $0201
	LDA #$1A
	STA playerax_u+1
	Chop playerax_u, playerax_u+3, GetTile, S, Z, offset
	JMP PunchDone

PunchDown:
	LDA #$09
	STA $0201
	LDA #$19
	STA playerax_d+1
	Chop playerax_d, playerax_d+3, GetTile, S, Z, offset
	JMP PunchDone

PunchLeft:
	LDA #$08
	STA $0201
	LDA #$18
	STA playerax_l+1
	Chop playerax_l, playerax_l+3, GetTile, S, Z, offset
	JMP PunchDone
	
PunchRight:
	LDA #$00
	STA playerax_r+2
	LDA #$07
	STA $0201
	LDA #$17
	STA playerax_r+1
	Chop playerax_r, playerax_r+3, GetTile, S, Z, offset
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
	;; LDA #$00
	;; STA playerfacing
;; 	LDA playerfacing
;; 	AND #%00001000
;; 	BEQ +
;; 	LDA #$02
;; 	STA shadow_oam+1
;; +		
;; 	LDA playerfacing
;; 	AND #%00000100
;; 	BEQ +
;; 	LDA #$01
;; 	STA shadow_oam+1
;; +
;; 	LDA playerfacing
;; 	AND #%00000010
;; 	BEQ +
;; 	LDA #$04
;; 	STA shadow_oam+1
;; +
;; 	LDA playerfacing
;; 	AND #%00000001
;; 	BEQ +
;; 	LDA #$03
;; 	STA shadow_oam+1
;; +
	
