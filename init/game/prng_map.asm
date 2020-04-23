Load_Lvl1:
vblankwait6:	
	BIT $2002
	BPL vblankwait6

	;; LDA #%10010000
	;; STA $2000
	LDA #$00
	STA $2001
LoadBackground:
	LDA $2002            
	LDA #$20
	STA $2006           
	LDA #$00
	STA $2006

	LDA $2000
	ASL
	TAY

	LDA bg_point+0, y
	STA Pointer+0
	LDA bg_point+1, y
	STA Pointer+1

	LDA #$04
	STA BG256
	LDX #$00
	LDY #$00
CopyByte:
	LDA (Pointer),y
	STA $2007
	INY
	INX
	BNE CopyByte
	INC Pointer+1
	LDA BG256
	SEC
	SBC #$01
	STA BG256
	BNE CopyByte

	LDA #$00
	STA $2002
	STA $2005
	STA $2005

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

	;; lda #%10010000
	;; sta $2000
	LDA #$00
	STA $2002
	STA $2005
	STA $2005
	LDA #%00011110
	STA $2001
