vblankwait2:   
	BIT $2002
	BPL vblankwait2

	LDA #%00000000
	STA $2001	

;; clrmem1:
;; 	LDA #$00
;; 	STA $0000, x
;; 	STA $0100, x
;; 	STA $0300, x
;; 	STA $0400, x
;; 	STA $0500, x
;; 	STA $0600, x
;; 	STA $0700, x
;; 	LDA #$FF
;; 	STA $0200, x		;shadow OAM
;; 	INX
;; 	BNE clrmem1

LoadBackground:
	LDA $2002            
	LDA #$20
	STA $2006           
	LDA #$00
	STA $2006           
	LDX #$00            

	LDY #$00

LoadBackgroundLoop1:	
	LDA background_lvl_1_1, y
	STA $2007
	INY
	INX
	CPX #$00
	BNE LoadBackgroundLoop1
	
LoadBackground2:
	LDA $2002
	LDA #$21
	STA $2006             
	LDA #$00
	STA $2006

	LDY #$00
	LDX #$00              
LoadBackgroundLoop2:		
	LDA background_lvl_1_2, y
	STA $2007
	INY
	INX
	CPX #$00
	BNE LoadBackgroundLoop2
	
LoadBackground3:
	LDA $2002
	LDA #$22
	STA $2006             
	LDA #$00
	STA $2006

	LDY #$00
	LDX #$00              
LoadBackgroundLoop3:	
	LDA background_lvl_1_3, y
	STA $2007
	INY
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
LoadBackgroundLoop4:	
	LDA background_lvl_1_4, y
	STA $2007
	INY
	INX
	CPX #$00
	BNE LoadBackgroundLoop4
	
LoadPalettes1:
	LDA $2002          
	LDA #$3F
	STA $2006            
	LDA #$00
	STA $2006          
	LDX #$00           
LoadPalettesLoop1:
	LDA palette, x       
	STA $2007           
	INX                   
	CPX #$20              
	BNE LoadPalettesLoop1 

LoadAttribute1:
	LDA $2002           
	LDA #$23
	STA $2006            
	LDA #$C0
	STA $2006         
	LDX #$00           
LoadAttributeLoop1:
	LDA attribute, x      
	STA $2007             
	INX                   
	CPX #$40              
	BNE LoadAttributeLoop1

	LDA #%00011110
	STA $2001
