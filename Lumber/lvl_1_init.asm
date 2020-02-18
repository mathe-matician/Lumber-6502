;------------------------------------
;level 1 init
;------------------------------------
	LDA #$00
	STA fake_player
	STA lvl1_npc_flags
	LDA #%00001000

	LDX #$04
	LDY #$00
LoadPlayer:
	LDA player_init, y
	STA shadow_oam, y
	INY
	DEX
	BNE LoadPlayer
	
	LDX #$10
	LDY #$00
LoadAx:
	LDA player_ax, y
	STA playerax_r, y
	INY
	DEX
	BNE LoadAx

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
