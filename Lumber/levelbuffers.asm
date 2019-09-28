level_1_buffer: ;tree block1
	.db $88,$00,$00,$88
	.db $88,$00,$00,$90
	.db $88,$00,$00,$98
	.db $90,$00,$00,$88
	.db $90,$20,$01,$90
	.db $90,$00,$00,$98
	.db $98,$00,$00,$88
	.db $98,$00,$00,$90
	.db $98,$00,$00,$98 ;$0227 last byte

coins_1_buffer: ;coins for tree block1
	.db $23

level_1_enemy1:
	.db $80,$15,$00,$80	;OAM $0228, $0229, $022A, $022B
