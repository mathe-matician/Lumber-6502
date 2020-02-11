;------------------------------------
;level 1 init
;------------------------------------
	LDA #$00
	STA fake_player
	STA lvl1_npc_flags
	
	;; can put this somehwere else and also in a buffer.
	LDA #$78
	STA shadow_oam
	LDA #$01
	STA shadow_oam+1
	LDA #$00
	STA shadow_oam+2
	LDA #$78
	STA shadow_oam+3

	LDX #$20
	LDY #$00
LoadNPC_lvl_1:
	LDA lvl_1_npcs, y
	STA $0204, y
	INY
	DEX
	BNE LoadNPC_lvl_1

	;; init variables
	LDA #$FF
	STA FrameCounter1
	;; TAX

	LDA #$01
	STA Level_1_Enemies

	LDX #$10
	LDY #$00
LoadENS_lvl_1:
	LDA level_1_enemy1, y
	STA $021C, y
	INY
	DEX
	BNE LoadENS_lvl_1

	;; LDA #%00000001		;will be able to move above to start screen once start is pressed.
	;; STA levels
	;; STA STATE
	
	LDA #%00000110 ;draw sprites
	STA draw_flags
