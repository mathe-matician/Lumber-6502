PlayerPunch:
	LDA new_button
	AND #%01000000		;B button for bashin'
	BEQ PuncherDone

	LDA playerfacing
	AND #%00001000
	BNE PunchUp

	LDA playerfacing
	AND #%00000100
	BNE PuncherDown
	
	LDA playerfacing
	AND #%00000010
	BNE PuncherLeft

	LDA playerfacing
	AND #%00000001
	BNE PuncherRight
	
	JMP PlayerActionDone
PuncherDone:
	JMP PunchDone
PuncherDown:
	JMP PunchDown
PuncherRight:
	JMP PunchRight
PuncherLeft:
	JMP PunchLeft
	
PunchUp:
	LDA #$0A
	STA shadow_oam+1
	LDA #$1A
	STA playerax_u+1
	;; prepare for GetTile subrout
	;; LDA playerax_u+3 ;x coord
	;; LDX playerax_u	 ;y coord
	;; jsr GetTile
	;; load ax direction into temps
	lda playerax_u+3
	sta ax_x_temp
	lda playerax_u
	sta ax_y_temp
	
	;; Chop playerax_u, playerax_u+3, GetTile, S, Z, offset
	JMP PunchDone

PunchDown:
	LDA #$09
	STA $0201
	LDA #$19
	STA playerax_d+1
	;; prepare for GetTile subrout
	;; LDA playerax_d+3 ;x coord
	;; LDX playerax_d	 ;y coord
	;; jsr GetTile
	;; load ax direction into temps
	lda playerax_d+3
	sta ax_x_temp
	lda playerax_d
	sta ax_y_temp
	
	;; Chop playerax_d, playerax_d+3, GetTile, S, Z, offset
	JMP PunchDone

PunchLeft:
	LDA #$08
	STA $0201
	LDA #$18
	STA playerax_l+1
	;; prepare for GetTile subrout
	;; LDA playerax_l+3 ;x coord
	;; LDX playerax_l	 ;y coord
	;; jsr GetTile
	;; load ax direction into temps
	lda playerax_l+3
	sta ax_x_temp
	lda playerax_l
	sta ax_y_temp
	
	;; Chop playerax_l, playerax_l+3, GetTile, S, Z, offset
	JMP PunchDone
	
PunchRight:
	;; LDA #$00
	;; STA playerax_r+2
	LDA #$07
	STA $0201
	LDA #$17
	STA playerax_r+1
	;; prepare for GetTile subrout
	;; LDA playerax_r+3 ;x coord
	;; LDX playerax_r	 ;y coord
	;; jsr GetTile
	;; load ax direction into temps
	lda playerax_r+3
	sta ax_x_temp
	lda playerax_r
	sta ax_y_temp
	;; Chop playerax_r, playerax_r+3, GetTile, S, Z, offset
PunchDone:
	;; JMP PlayerActionDone
	rts	       ;newly added test
	
Player_Chop:
	LDA ax_x_temp
	LDX ax_y_temp
	jsr GetTile
	cmp #$3B
	BEQ @Chop_Done ;; test

	LDA ax_x_temp
	LDX ax_y_temp
	;; divide x by 8 and store this in the offset to use later
	lsr
	lsr
	lsr
	sta offset
	;; zero out Z+1 and get the msb
	lda #$00
	sta Z+1
	txa
	and #%11111000
	;; multiply y by 32
	asl
	rol Z+1
	asl
	rol Z+1
	;; add the result to the base address of the NT
	adc ppu_base+0
	sta Z+0
	lda Z+1
	adc ppu_base+1
	sta Z+1
	;; add the offset
	lda Z+0
	clc
	adc offset
	sta Z+0
	;; update ppu
	lda $2002
	lda Z+1
	sta $2006
	lda Z+0
	sta $2006
	lda #$00
	sta $2007
	sta $2005
	sta $2005

	lda whattile_player
	;; lda s_y
	;; tay
	;; lda (S), y
	;; above test
	;; cmp #$3b
	;; beq @Chop_Done ; this alone makes the score go out of control up
	cmp #$04
	bne @Chop_Done
	DEC PlayerTreeDraw_Flag
	inc PlayerTreeCount
	;; lda #$00
	;; sta whattile_player
@Chop_Done:
	rts

PlayerActionDone:
	rts
