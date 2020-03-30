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

	;; JSR sound_init
	;; clear previous background if new game started
clr6000:
	LDA #$00
	STA $6000, x
	STA $6100, x
	STA $6200, x
	STA $6300, x
	INX
	BNE clr6000
 
vblankwait0:
	BIT $2002
	BPL vblankwait0

	LDA #%10010000
	STA $2000
