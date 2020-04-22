LoadPauseScreen:
;; 	BIT $2002
;; 	BPL LoadPauseScreen
;; @SaveforUnPause:
;; 	LDA $2002
;; 	LDA #$21
;; 	STA $2006
;; 	LDA #$6D
;; 	STA $2006

;; 	LDX #$09
;; 	LDY #$00
;; @load1:
;; 	LDA $2007
;; 	STA unpause, y
;; 	INY
;; 	DEX
;; 	BNE @load1

;; 	LDA $2002
;; 	LDA #$21
;; 	STA $2006
;; 	LDA #$8D
;; 	STA $2006

;; 	LDX #$09
;; 	LDY #$09
;; @load2:
;; 	LDA $2007
;; 	STA unpause, y
;; 	INY
;; 	DEX
;; 	BNE @load2

;; 	LDA $2002
;; 	LDA #$21
;; 	STA $2006
;; 	LDA #$AD
;; 	STA $2006

;; 	LDX #$09
;; 	LDY #$12
;; @load3:
;; 	LDA $2007
;; 	STA unpause, y
;; 	INY
;; 	DEX
;; 	BNE @load3
;; 	BIT $2002
;; 	BPL LoadPauseScreen

;; @LoadScreen:
;; 	BIT $2002
;; 	BPL @LoadScreen
	
	LDA #$00
	STA $2001

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$6D
	STA $2006

	LDX #$09
	LDY #$00
@loadtext1:
	LDA pause, y
	STA $2007
	INY
	DEX
	BNE @loadtext1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$8D
	STA $2006

	LDX #$09
	LDY #$09
@loadtext2:
	LDA pause, y
	STA $2007
	INY
	DEX
	BNE @loadtext2

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$AD
	STA $2006

	LDX #$09
	LDY #$12
@loadtext3:
	LDA pause, y
	STA $2007
	INY
	DEX
	BNE @loadtext3

	LDA #%00011110
	STA $2001
	LDA #$00
	STA $2005
	STA $2005

	RTS

LoadUnPauseScreen:
	;; BIT $2002
	;; BPL LoadUnPauseScreen
	
	LDA #$00
	STA $2001

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$6D
	STA $2006

	LDX #$09
	LDY #$00
@loadtext1:
	LDA unpause, y
	STA $2007
	INY
	DEX
	BNE @loadtext1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$8D
	STA $2006

	LDX #$09
	LDY #$09
@loadtext2:
	LDA unpause, y
	STA $2007
	INY
	DEX
	BNE @loadtext2

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$AD
	STA $2006

	LDX #$09
	LDY #$12
@loadtext3:
	LDA unpause, y
	STA $2007
	INY
	DEX
	BNE @loadtext3

	LDA #%00011110
	STA $2001
	LDA #$00
	STA $2005
	STA $2005
	
	RTS
