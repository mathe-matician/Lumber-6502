LoadTimeUpScreen:
	BIT $2002
	BPL LoadTimeUpScreen

	LDA #$00
	STA $2001

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$0B
	STA $2006

	LDX #$0C
	LDY #$00
@Load1:
	LDA timeup, y
	STA $2007
	INY
	DEX
	BNE @Load1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$2B
	STA $2006

	LDX #$0C
	LDY #$0C
@Load2:
	LDA timeup, y
	STA $2007
	INY
	DEX
	BNE @Load2

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$4B
	STA $2006

	LDX #$0C
	LDY #$18
@Load3:
	LDA timeup, y
	STA $2007
	INY
	DEX
	BNE @Load3

	LDA #%00011110
	STA $2001
	LDA #$00
	STA $2005
	STA $2005

	RTS

LoadHumansWin:
	BIT $2002
	BPL LoadHumansWin

	lda #$00
	jsr sound_load
	lda #$03
	jsr sound_load
	
	LDA #$00
	STA $2001

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$0B
	STA $2006

	LDX #$0C
	LDY #$00
@Load1:
	LDA humanswin, y
	STA $2007
	INY
	DEX
	BNE @Load1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$2B
	STA $2006

	LDX #$0C
	LDY #$0C
@Load2:
	LDA humanswin, y
	STA $2007
	INY
	DEX
	BNE @Load2

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$4B
	STA $2006

	LDX #$0C
	LDY #$18
@Load3:
	LDA humanswin, y
	STA $2007
	INY
	DEX
	BNE @Load3

	LDA #%00011110
	STA $2001
	LDA #$00
	STA $2005
	STA $2005
	
	RTS

LoadAliensWin:
	BIT $2002
	BPL LoadAliensWin

	lda #$00
	jsr sound_load
	LDA #$05
	jsr sound_load
	
	LDA #$00
	STA $2001

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$0B
	STA $2006

	LDX #$0C
	LDY #$00
@Load1:
	LDA alienswin, y
	STA $2007
	INY
	DEX
	BNE @Load1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$2B
	STA $2006

	LDX #$0C
	LDY #$0C
@Load2:
	LDA alienswin, y
	STA $2007
	INY
	DEX
	BNE @Load2

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$4B
	STA $2006

	LDX #$0C
	LDY #$18
@Load3:
	LDA alienswin, y
	STA $2007
	INY
	DEX
	BNE @Load3

	LDA #%00011110
	STA $2001
	LDA #$00
	STA $2005
	STA $2005
	
	RTS

LoadScoreTie:
	BIT $2002
	BPL LoadScoreTie
	
	LDA #%00000000
	STA $2001

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$0B
	STA $2006

	LDX #$0C
	LDY #$00
@Load1:
	LDA tie, Y
	STA $2007
	INY
	DEX
	BNE @Load1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$2B
	STA $2006

	LDX #$0C
	LDY #$0C
@Load2:	
	LDA tie, Y
	STA $2007
	INY
	DEX
	BNE @Load2

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$4B
	STA $2006

	LDX #$0C
	LDY #$18
@Load3:
	LDA tie, Y
	STA $2007
	INY
	DEX
	BNE @Load3

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$6B
	STA $2006

	LDX #$0C
	LDY #$24
@Load4:
	LDA tie, Y
	STA $2007
	INY
	DEX
	BNE @Load4

	LDA #%00011110
	STA $2001
	LDA #$00
	STA $2005
	STA $2005

	RTS
