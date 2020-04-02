StartScreen:
	
	LDA #$00		;start screen
	STA levels
	STA STATE
	STA lvl1_npc_flags

	LDA #%00011110
	STA draw_flags
	
@StartLoop:
	LDA STATE
	AND #%00000001
	BEQ @StartLoop
