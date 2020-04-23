RESET:
	SEI			
	CLD			
	LDX #$40
	STX $4017		
	LDX #$FF
	TXS			
	INX
	STX $2000
	STX $2001
	STX $4010

	;; LDA #%10010000
	;; STA $2000

	BIT $2002
	
vblankwait1:
	BIT $2002
	BPL vblankwait1

clrmem:
	LDA #$00
	STA $0000, x
	STA $0100, x
	STA $0300, x
	STA $0400, x
	STA $0500, x
	STA $0600, x
	STA $0700, x
	LDA #$FF
	STA $0200, x		;shadow OAM
	INX
	BNE clrmem

	;; clear previous background if new game started
clr6000:
	LDA #$00
	STA $6000, x
	STA $6100, x
	STA $6200, x
	STA $6300, x
	STA $6400, x
	INX
	BNE clr6000

	lda #$00
	sta timer_ones_top+0
	sta timer_ones_top+1
	sta timer_tens_top+0
	sta timer_tens_top+1
	sta timer_ones_bottom+0
	sta timer_ones_bottom+1
	sta timer_tens_bottom+0
	sta timer_tens_bottom+1
	sta Timer_Ones_Top_Point+0
	sta Timer_Ones_Top_Point+1
	sta Timer_Ones_Bottom_Point+0
	sta Timer_Ones_Bottom_Point+1
	sta Timer_Tens_Top_Point+0
	sta Timer_Tens_Top_Point+1
	sta Timer_Tens_Bottom_Point+0
	sta Timer_Tens_Bottom_Point+1
vblankwait0:
	BIT $2002
	BPL vblankwait0
	LDA $2002
	LDA #%10010000
	STA $2000


	JSR sound_init
	LDA #$01
	;; sta current_song
	JSR sound_load
