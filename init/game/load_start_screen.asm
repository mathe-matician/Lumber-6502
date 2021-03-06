vblankwait3:   
	BIT $2002
	BPL vblankwait3

LoadStartScreen:
	LDA $2002
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
	;; LDY #$00

@Loop1:				;just testing local labels
	;; LDA #$00, Y
	LDA #$00
	STA $2007
	;; INY
	INX
	CPX #$00
	BNE @Loop1

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

LoadStartScreen2:
	LDA $2002
	LDA #$21
	STA $2006
	LDA #$00
	STA $2006

	LDX #$40
	;; LDY #$00

LoadStartScreenLoop2:
	;; LDA #$00, Y
	LDA #$00
	STA $2007
	;; INY
	DEX
	BNE LoadStartScreenLoop2

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

	LDX #$00
	LDY #$00
	
LoadStartScreenLoop2_1:	
	LDA start_screen, Y
	STA $2007
	INY
	INX
	CPX #$00
	BNE LoadStartScreenLoop2_1

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

LoadStartScreen3:
	LDA $2002
	LDA #$22
	STA $2006
	LDA #$00
	STA $2006

	LDX #$20
	LDY #$00

LoadStartScreenLoop3:
	LDA start_screen1, Y
	STA $2007
	INY
	DEX
	BNE LoadStartScreenLoop3

	LDA #$00
	STA $2002
	STA $2005
	STA $2005
	
	LDX #$00
	;; LDY #$00

LoadStartScreenLoop3_1:
	;; LDA #$00, Y
	LDA #$00
	STA $2007
	;; INY
	INX
	CPX #$00
	BNE LoadStartScreenLoop3_1

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

LoadStartScreen4:
	LDA $2002
	LDA #$23
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
	;; LDY #$00

LoadStartScreenLoop4:
	;; LDA #$00, Y
	LDA #$00
	STA $2007
	;; INY
	INX
	CPX #$00
	BNE LoadStartScreenLoop4

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

	;; does this only need to be loaded once?
LoadPalettes:
	LDA $2002             ; read PPU status to reset the high/low latch
	LDA #$3F
	STA $2006             ; write the high byte of $3F00 address
	LDA #$00
	STA $2006             ; write the low byte of $3F00 address
	LDX #$00              ; start out at 0
LoadPalettesLoop:
	LDA palette, x       
	STA $2007             ; write to PPU
	INX                   
	CPX #$20              
	BNE LoadPalettesLoop

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

LoadAttribute:
	LDA $2002             ; read PPU status to reset the high/low latch
	LDA #$23
	STA $2006             ; write the high byte of $23C0 address
	LDA #$C0
	STA $2006             ; write the low byte of $23C0 address
	LDX #$00              ; start out at 0
LoadAttributeLoop:
	LDA attribute, x      
	STA $2007             
	INX                   
	CPX #$40              
	BNE LoadAttributeLoop
