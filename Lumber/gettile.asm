GetTile:
	;; X coordinate in register A, Y coordinate in register X
	;; LDA playerax_r+3	;x coordinate
	;; LDX playerax_r		;y coordinate
	;divide the X coordinate by 8
	lsr
	lsr
	lsr
	tay
	;multiplication by 32 of the Y coordinate
	lda #$00
	sta S+1
	txa
	and #%11111000
	asl
	rol S+1
	asl
	rol S+1
	;add the result to the base address of the NT
	adc bg_point+0
	sta S+0
	lda S+1
	adc bg_point+1
	sta S+1
	
	;get the tile
	lda (S), y
	;; CMP #$04
	;; BNE GetTileDone

	;; zeros out tile in PRGROM ($6000) logically you can now walk through spaces that have been chopped
	LDA #$00
	STA (S), Y
	STA Z
	STA offset
GetTileDone:	

;;; ;;;;;;;;;;;;;;;;;;;;
	;; LDA playerax_r+3	;x coordinate
	;; LDX playerax_r		;y coordinate
	;; ;; divide x coordinate by 8 and store x-offset in variable
	;; lsr
	;; lsr
	;; lsr
	;; STA offset
	;; ;; zero out Z+1 and get the lower bits
	;; lda #$00
	;; sta Z+1
	;; txa
	;; and #%11111000
	;; ;; multiply y coordinate by 32
	;; asl
	;; rol Z+1
	;; asl
	;; rol Z+1
	;; ;add the result to the base address of the NT
	;; adc ppu_base+0
	;; sta Z+0
	;; lda Z+1
	;; adc ppu_base+1
	;; sta Z+1

	;; ;; add 
	;; LDA Z+0
	;; CLC
	;; ADC offset
	;; STA Z+0

	;; LDA $2002
	;; LDA Z+1
	;; STA $2006
	;; LDA Z+0
	;; STA $2006
	;; LDA #$00
	;; STA $2007
	;; STA $2005
	;; STA $2005

	RTS
