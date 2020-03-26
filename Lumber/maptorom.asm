;; vblankwait2:   
;; 	BIT $2002
	;; 	BPL vblankwait2
	;; LDA #$00
	;; STA $2001

	;; LDA #%10010000
	;; STA $2000
	
	LDA #$00
	STA Point+0
	STA Point+1
BGTORAM:
	LDA $6000	
	ASL
	TAY

	LDA bg_point+0,y
	STA Point+0
	LDA bg_point+1,y
	STA Point+1

	LDX #$04
	LDY #$00
	TYA
	PHA
PRNG_MAP:	
	LDY #$08	
	LDA seed2+0
One:
	ASL
	ROL seed2+1
	BCC Two
	EOR #$39	
Two:	
	DEY
	BNE One
	STA seed2+0
	CMP #$00

	LDA seed2
	CMP #$0C
	BCC LoadRock		; if seed2 < 12:
	CMP #$AA
	BCC LoadGrass		;if seed2 < 170 and is greater than 12
	CMP #$FF
	BCC LoadTree		;if seed2 < 254 and is greater than 170
	JMP LoadTree		;if 255 still load a tree!
LoadRock:
	PLA
	TAY
	LDA #$3B
	STA (Point), y
	JMP LoadCycle
LoadGrass:
	PLA
	TAY
	LDA #$00
	STA (Point), y
	JMP LoadCycle
LoadTree:
	PLA
	TAY
	LDA #$04
	STA (Point), y
LoadCycle:
	INY
	TYA
	PHA
	CPY #$00
	BNE PRNG_MAP
	INC Point+1
	DEX
	BNE PRNG_MAP
BGDone:	
