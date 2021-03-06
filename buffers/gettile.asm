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
	sty s_y	;test
	
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
	lda (S), y
	sta whattile_player
	;get the tile
	;; lda (S), y
	;; CMP #$3B
	;; BEQ GetTileDone
	lda (S), y
	CMP #$04
	BNE GetTileDone
	;; zeros out tile in PRGROM ($6000) logically you can now walk through spaces that have been chopped
	LDA #$00
	STA (S), Y
	STA Z
	STA offset
	
GetTileDone:	
	RTS
