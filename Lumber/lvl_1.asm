vblankwait2:   
	BIT $2002
	BPL vblankwait2

	LDA #%10010000
	STA $2000
	LDA #%00000000
	STA $2001	

LoadBackground:
	LDA $2002            
	LDA #$20
	STA $2006           
	LDA #$00
	STA $2006

	;; put the map index (nametable address) in register A going into this
	LDA $2000
	;; multiply index by 2, since it is 16bit
	ASL
	TAY

	LDA lvl_1bg_ptr+0, y
	STA Pointer+0
	LDA lvl_1bg_ptr+1, y
	STA Pointer+1

	;; copy 1024 bytes from the location indicated by the pointer to VRAM
	LDA #$03
	STA BG256
	LDX #$00
	LDY #$00
CopyByte:
	LDA (Pointer), y
	TAX
	INY
CBLoop:	
	LDA (Pointer), y
	STA $2007
	DEX
	BNE CBLoop
	INY
	BNE CopyByte
	INC Pointer+1
	LDA BG256
	SEC
	SBC #$01
	STA BG256
	BNE CopyByte
	
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

	LDA #$00
	STA $2005
	STA $2005
	LDA #%00011110
	STA $2001
