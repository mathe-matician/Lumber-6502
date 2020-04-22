PlayerDeathCheck1:
	LDY #$00
	LDA En_Y1+0, y
	STA EnPoint1Y+0
	LDA En_Y1+1, y
	STA EnPoint1Y+1

	LDA En_X1+0, y
	STA EnPoint1X+0
	LDA En_X1+1, y
	STA EnPoint1X+1
	LDX #$0C
En_Loc_Check1:	
	LDA (EnPoint1Y), y
	CMP shadow_oam
	BNE En_Loc_Check_Done1
	LDA (EnPoint1X), y
	CMP shadow_oam+3
	BNE En_Loc_Check_Done1
	JMP En_Hit
En_Loc_Check_Done1:
	LDA EnPoint1Y+0
	CLC
	ADC #$04
	STA EnPoint1Y+0
	LDA EnPoint1X+0
	CLC
	ADC #$04
	STA EnPoint1X+0
	DEX
	BNE En_Loc_Check1
	JMP DeathCheckDone
En_Hit:	
	LDA #$03
	STA shadow_oam+2
	LDA #$00	;could just load into the start control
	STA STATE	;STATE
	LDA #%00000010
	STA STATE	;STATE
	JSR LoadGameOverScreen
	JMP GameOver
DeathCheckDone:	
	RTS
