chop:	
	;; TileTranslate S, Q, playerax_r, playerax_r+3, $6000
	;; CMP #$04
	;; BNE chopdone
	
	;; X coordinate in register A, Y coordinate in register X
	LDA playerax_r+3
	LDX playerax_r
GetTile:
	;divide the X coordinate by 8
	lsr
	lsr
	lsr
	tay
	;simulate a division by 8 followed by a multiplication by 32 of the Y coordinate
	lda #$00
	sta S+1
	txa
	and #%11111000
	asl
	rol S+1
	asl
	rol S+1
	;add the result to the base address of the NT
	adc bg_point_ram+0
	sta S+0
	lda S+1
	adc bg_point_ram+1
	sta S+1
	;get the tile
	lda (S), y

	LDA #$00
	STA (S), Y
	
	LDA #$03
	STA playerax_r+2

chopdone:
	RTS
