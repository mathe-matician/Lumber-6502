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

	LDA #$00
	STA BG256
	TAY
	TAX
LoadBackgroundLoop1_RLE:
	LDA background_lvl_1_1_rle, y
	TAX
	INY
Loop1:
	LDA background_lvl_1_1_rle, y
	STA $2007
	LDA #$00
	STA $2005
	STA $2005
	DEX
	BNE Loop1
	INY
	LDA BG256
	CLC
	ADC #$01
	STA BG256
	LDA BG256
	CMP #$80
	BNE LoadBackgroundLoop1_RLE
	
LoadBackground2:
	LDA $2002
	LDA #$21
	STA $2006             
	LDA #$8B
	STA $2006

	LDA #$00
	STA BG256
	TAY
	TAX
LoadBackgroundLoop2_RLE:
	LDA background_lvl_1_2_rle, y
	TAX
	INY
Loop2:
	LDA background_lvl_1_2_rle, y
	STA $2007
	LDA #$00
	STA $2005
	STA $2005
	DEX
	BNE Loop2
	INY
	LDA BG256
	CLC
	ADC #$01
	STA BG256
	LDA BG256
	CMP #$80
	BNE LoadBackgroundLoop2_RLE

	
	
LoadBackground3:
	LDA $2002
	LDA #$22
	STA $2006             
	LDA #$8F
	STA $2006

	LDA #$00
	STA BG256
	TAY
	TAX
LoadBackgroundLoop3_RLE:
	LDA background_lvl_1_3_rle, y
	TAX
	INY
Loop3:
	LDA background_lvl_1_3_rle, y
	STA $2007
	LDA #$00
	STA $2005
	STA $2005
	DEX
	BNE Loop3
	INY
	LDA BG256
	CLC
	ADC #$01
	STA BG256
	LDA BG256
	CMP #$62
	BNE LoadBackgroundLoop3_RLE
	
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
