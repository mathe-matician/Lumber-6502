vblankwait2:   
	BIT $2002
	BPL vblankwait2

	LDA #%10010000
	STA $2000
	LDA #%00000000
	STA $2001

	LDX #$00
	LDY #$00
Bg_To_RAM1:
	LDA background_lvl_1_1, y
	STA $6000, y
	INY
	INX
	BNE Bg_To_RAM1

	LDX #$00
	LDY #$00
Bg_To_RAM2:
	LDA background_lvl_1_2, y
	STA $6100, y
	INY
	INX
	BNE Bg_To_RAM2

	LDX #$00
	LDY #$00
Bg_To_RAM3:
	LDA background_lvl_1_3, y
	STA $6200, y
	INY
	INX
	BNE Bg_To_RAM3
Bg_To_RAM4:
	LDA background_lvl_1_4, y
	STA $6300, y
	INY
	INX
	BNE Bg_To_RAM4

;; 	LDA #$00
;; 	STA Point+0
;; 	STA Point+1
;; BGTORAM:
;; 	;; put the map index  in register A 
;; 	LDA $6000
;; 	;; multiply index by 2, since it is 16bit
;; 	ASL
;; 	TAY

;; 	LDA background_lvl_1_1_rle+0,y
;; 	STA Point+0
;; 	LDA background_lvl_1_1_rle+1,y
;; 	STA Point+1
;; 	;; copy 1024 bytes from the location indicated by the pointer to VRAM
;; 	LDA #$02
;; 	STA BG256
;; 	LDX #$00
;; 	LDY #$00
;; bbbCopyByte:
;; 	LDA (Point), y
;; 	TAX
;; 	INY
;; bbbCBLoop:	
;; 	LDA (Point), y
;; 	STA $6000
;; 	INC $6000
;; 	DEX
;; 	BNE bbbCBLoop
;; 	INY
;; 	BNE bbbCopyByte
;; 	INC Point+1
;; 	LDA BG256
;; 	SEC
;; 	SBC #$01
;; 	STA BG256
;; 	BNE bbbCopyByte
	
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

	;; LDA lvl_1bg_ptr+0, y
	;; STA Pointer+0
	;; LDA lvl_1bg_ptr+1, y
	;; STA Pointer+1

	LDA bg_point_ram+0, y
	STA Pointer+0
	LDA bg_point_ram+1, y
	STA Pointer+1
	;; copy 1024 bytes from the location indicated by the pointer to VRAM
	LDX #$04
	LDY #$00
CopyByte:
	LDA (Pointer), y
	STA $2007
	INY
	BNE CopyByte
	INC Pointer+1
	DEX
	BNE CopyByte

;; 	;; put the map index (nametable address) in register A going into this
;; 	LDA $2000
;; 	;; multiply index by 2, since it is 16bit
;; 	ASL
;; 	TAY

;; 	;; LDA lvl_1bg_ptr+0, y
;; 	;; STA Pointer+0
;; 	;; LDA lvl_1bg_ptr+1, y
;; 	;; STA Pointer+1

;; 	LDA bg_point_ram+0, y
;; 	STA Pointer+0
;; 	LDA bg_point_ram+1, y
;; 	STA Pointer+1
;; 	;; copy 1024 bytes from the location indicated by the pointer to VRAM
;; 	LDA #$02
;; 	STA BG256
;; 	LDX #$00
;; 	LDY #$00
;; CopyByte:
;; 	LDA (Pointer), y
;; 	TAX
;; 	INY
;; CBLoop:	
;; 	LDA (Pointer), y
;; 	STA $2007
;; 	DEX
;; 	BNE CBLoop
;; 	INY
;; 	BNE CopyByte
;; 	INC Pointer+1
;; 	LDA BG256
;; 	SEC
;; 	SBC #$01
;; 	STA BG256
;; 	BNE CopyByte
	
	
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
