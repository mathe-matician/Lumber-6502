	;; BCC is branch if less than
	;; BCS is branch if greater than or equal

	;; player bounding box
	LDA collide_vertical_player	;player y
	CLC
	ADC #$07
	STA p_collide_vert_col_2

	LDA collide_horizontal_player ;player x
	CLC
	ADC #$07
	STA p_collide_hor_col_1
	LDA p_collide_vert_col_2 
	CLC
	ADC #$07
	STA p_collide_hor_col_2

	;; enemy 1 bounding box
	
	
PlayerCollision:
	;; LDA collide_vertical_player
	;; CMP $0229		;enemy sprite
	;; BCC No_Collision
	;; LDA collide_vertical_player
	;; CMP $0229
	;; BCS No_Collision
	
	;; LDA p_collide_vert_col_2
	;; CMP $0229
	;; BCC No_Collision
	;; LDA p_collide_vert_col_2
	;; CMP $0229
	;; BCS No_Collision

	;; need more collision logic

	JMP No_Collision
	
Collision:
	LDA #$02
	STA $0202
	JMP CollisionDone
No_Collision:	
	LDA #$00
	STA $0202
CollisionDone:
