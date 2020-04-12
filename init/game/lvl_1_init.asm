;------------------------------------
;level 1 init
;------------------------------------
	LDA #$00
	STA fake_player
	STA lvl1_npc_flags
	STA enemy_num_tablecheck+0
	STA enemy_num_tablecheck+1
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
	;; CMP #$A0
	;; BCC Load7En
	;; CMP #$B0
	;; BCC Load8En
	;; CMP #$E0
	;; BCC Load10En
	;; CMP #$FE
	;; BCC Load12En
		;; LDX #$10 - put in below - possibly won't need
	;; JMP Load12En
Load4Ens:
	LDA #$04
	STA enemy_num
	LDA #$24
	STA OAM_Num
	LDX #$10
	JMP LoadEns
Load5En:
	LDA #$05
	STA enemy_num
	LDA #$28
	STA OAM_Num
	LDX #$14
	JMP LoadEns
Load6En:
	LDA #$06
	STA enemy_num
	LDA #$2C
	STA OAM_Num
	LDX #$18
	JMP LoadEns
;; Load7En:
;; 	LDA #$07
;; 	STA enemy_num
;; 	LDA #$03
;; 	STA enemy_num_tablecheck
;; 	LDX #$1C
;; 	JMP LoadEns
;; Load8En:
;; 	LDA #$08
;; 	STA enemy_num
;; 	LDA #$04
;; 	STA enemy_num_tablecheck
;; 	LDX #$20
;; 	JMP LoadEns
;; Load10En:
;; 	LDA #$0A
;; 	STA enemy_num
;; 	LDA #$05
;; 	STA enemy_num_tablecheck
;; 	LDX #$28
;; 	JMP LoadEns
;; Load12En:
;; 	LDA #$0C
;; 	STA enemy_num
;; 	LDA #$06
;; 	STA enemy_num_tablecheck
;; 	LDX #$30
LoadEns
	;; LDA #$00
	;; STA enemy_num_tablecheck+0
	;; STA enemy_num_tablecheck+1
	;; TAY
	LDA #$00
	TAY
LoadENS_lvl_1:
	LDA level_1_enemy1, y	;starting at $0214
	STA En1_LocY, y
	INY
	DEX
	BNE LoadENS_lvl_1
	
	LDA #%00000110 ;draw sprites
	STA draw_flags
