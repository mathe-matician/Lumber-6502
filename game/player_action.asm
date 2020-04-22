PlayerPunch:
	LDA new_button
	AND #%01000000		;B button for bashin'
	BEQ PuncherDone

	LDA playerfacing
	AND #%00001000
	BNE PunchUp

	LDA playerfacing
	AND #%00000100
	BNE PuncherDown
	
	LDA playerfacing
	AND #%00000010
	BNE PuncherLeft

	LDA playerfacing
	AND #%00000001
	BNE PuncherRight
	
	JMP PlayerActionDone
PuncherDone:
	JMP PunchDone
PuncherDown:
	JMP PunchDown
PuncherRight:
	JMP PunchRight
PuncherLeft:
	JMP PunchLeft
	
PunchUp:
	LDA #$0A
	STA shadow_oam+1
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

BeDone:	
	JMP PlayerActionDone

PlayerActionDone:
