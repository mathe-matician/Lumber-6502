;;; all consolidated to controls

CheckPlayerCollision:

	;; LDA #$00
	;; STA L
	;; LDA shadow_oam		;player-y #$78
	;; AND #%11111000
	;; ASL
	;; ROL L
	;; ASL
	;; ROL L
	;; ADC #<background_lvl_1_1
	;; STA H
	;; LDA L
	;; ADC #>background_lvl_1_1
	;; STA L
	;; LDA shadow_oam+3	;player-x #$78
	;; LSR
	;; LSR
	;; LSR			;divide by 8
	;; TAY
	
	;; LDA (H), Y
	;; STA fake_player
	;; CMP #$04
	;; BEQ Collision_Tree

	JMP No_Collision

	
Collision_Tree:
	
	LDA #$02
	STA $0202
	LDA #%00000001
	STA collidebits
	JMP CollisionDone

Collision_Enemy:
	;; have to calculate enemy position - should be simpler because the enemy is a sprite.
	LDA #%00000010
	STA collidebits
	JMP CollisionDone

Collision_Gold:
	;; have to calculate fire position - should be simpler because the fire is a sprite
	LDA #%00000100
	STA collidebits
	JMP CollisionDone
	
No_Collision:	
	LDA #$00
	STA $0202
	STA collidebits
CollisionDone:
