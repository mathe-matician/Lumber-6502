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

	LDA #%10010000
	STA $2000
	;; JMP ClearMem
	;; JMP LoadBackground
	
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
   
vblankwait2:   
	BIT $2002
	BPL vblankwait2

;; LoadSprites:
;; 	LDX #$00
;; LoadSpritesLoop:
;; 	LDA sprites, x
;; 	STA $0200, x
;; 	INX
;; 	CPX #$08
;; 	BNE LoadSpritesLoop

LoadBackground:
	LDA $2002             ; read PPU status to reset the high/low latch
	LDA #$20
	STA $2006             ; write the high byte of $2000 address
	LDA #$00
	STA $2006             ; write the low byte of $2000 address
	LDX #$00              ; start out at 0
;; LoadBackgroundLoop1:
;; 	;;;;; LDA background, x     
;; 	TXA
;; 	STA $2007             
;; 	INX                   
;; 	CPX #$00              
;; 	BNE LoadBackgroundLoop1

LoadBackgroundLoop1:		;single grass color
	LDA #$01
	STA $2007
	INX
	CPX #$00
	BNE LoadBackgroundLoop1
	
LoadBackground2:
	LDA $2002
	LDA #$21
	STA $2006             
	LDA #$00
	STA $2006
	
	LDX #$00              
LoadBackgroundLoop2:		;single grass color
	LDA #$01
	STA $2007
	INX
	CPX #$00
	BNE LoadBackgroundLoop2
	
LoadBackground3:
	LDA $2002
	LDA #$22
	STA $2006             
	LDA #$00
	STA $2006
	
	LDX #$00              
LoadBackgroundLoop3:		;single grass color
	LDA #$01
	STA $2007
	INX
	CPX #$00
	BNE LoadBackgroundLoop3
	
LoadBackground4:
	LDA $2002
	LDA #$23
	STA $2006             
	LDA #$00
	STA $2006
	
	LDX #$00              
LoadBackgroundLoop4:		;single grass color
	LDA #$01
	STA $2007
	INX
	CPX #$00
	BNE LoadBackgroundLoop4

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


	;; JSR DoFrame
