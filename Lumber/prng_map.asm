vblankwait2:   
	BIT $2002
	BPL vblankwait2

	LDA #%10010000
	STA $2000
	LDA #%00000000
	STA $2001

	LDA #$00
	STA BG256
	LDA #$04
	STA BGCount
	LDA #$23
	STA seed2+0
	LDA #$60
	STA seed2+1
PRNG_MAP:	
	LDY #$08		;iteration count (generates 8 bits)
	LDA seed2+0
One:
	ASL
	ROL seed2+1
	BCC Two
	EOR #$39		;apply XOR feedback whenever a 1 bit is shifted out
Two:
	DEY
	BNE One
	STA seed2+0
	CMP #$00		;reload flags

	LDA seed2
	CMP #$0C
	BCC LoadRock		; if seed2 < 12:
	CMP #$25
	BCC LoadTree		;if seed2 < 37 and it is greater than 12
	CMP #$CF
	BCC LoadGrass		;if seed2 < 207 and is greater than 37
	CMP #$FF
	BCC LoadTree		;if seed2 < 255 and is greater than 207
	JMP BGDone
LoadRock:
	LDA #$3B
	STA PRGROM, x
	JMP LoadCycle
LoadGrass:
	LDA #$00
	STA PRGROM, x
	JMP LoadCycle
LoadTree:	
	LDA #$04
	STA PRGROM, x
LoadCycle:
	INX
	BNE PRNG_MAP
	DEC BGCount
	BEQ BGDone
	JMP PRNG_MAP
BGDone:

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
	LDA #$01
	STA BG256
	LDX #$00
	LDY #$00
CopyByte:
	LDA (Pointer),y
	STA $2007
	INY
	DEX
	BNE CopyByte
	INC Pointer+1
	LDA BG256
	SEC
	SBC #$01
	STA BG256
	BNE CopyByte
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
