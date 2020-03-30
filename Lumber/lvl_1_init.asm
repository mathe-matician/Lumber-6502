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
	LDA player_init, y	;starting at $0200
	STA shadow_oam, y
	INY
	DEX
	BNE LoadPlayer
	
	LDX #$10
	LDY #$00
LoadAx:
	LDA player_ax, y	;starting at $0204 - $0210
	STA playerax_r, y
	INY
	DEX
	BNE LoadAx

;; 	LDX #$20
;; 	LDY #$00
;; LoadNPC_lvl_1:
;; 	LDA lvl_1_npcs, y
;; 	STA $0204, y
;; 	INY
;; 	DEX
;; 	BNE LoadNPC_lvl_1

	;; init variables
	LDA #$FF
	STA FrameCounter1

	LDA #$01
	STA Level_1_Enemies

	LDA seed2
	CMP #$20
	BCC Load5En
	CMP #$80
	BCC Load6En
	CMP #$A0
	BCC Load7En
	CMP #$B0
	BCC Load8En
	CMP #$E0
	BCC Load10En
	CMP #$FE
	BCC Load12En
	LDX #$10
	JMP LoadEns
Load5En:
	LDX #$14
	JMP LoadEns
Load6En:
	LDX #$18
	JMP LoadEns
Load7En:
	LDX #$1C
	JMP LoadEns
Load8En:
	LDX #$20
	JMP LoadEns
Load10En:
	LDX #$28
	JMP LoadEns
Load12En:
	LDX #$30

LoadEns:
	LDY #$00
LoadENS_lvl_1:
	LDA level_1_enemy1, y	;starting at $0214
	STA En1_LocY, y
	INY
	DEX
	BNE LoadENS_lvl_1
	
	LDA #%00000110 ;draw sprites
	STA draw_flags
