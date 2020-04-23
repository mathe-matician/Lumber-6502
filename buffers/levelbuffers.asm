
player_init:
	.db $78,$01,$00,$78 	;$0200, $0201, $0202, $0203 - player starting position
	
player_ax:	
	.db $78,$16,$00,$80	;$0204
	.db $78,$16,$00,$70	;$0208
	.db $70,$16,$00,$78	;$020C
	.db $80,$16,$00,$78	;$0210

level_1_enemy1:
	.db $28,$15,$03,$20	;$0214 - Enemy1
	.db $C0,$15,$03,$08	;$0218 - Enemy2
	.db $C8,$15,$03,$E0	;$021C - Enemy3
	.db $50,$15,$03,$B8	;$0220 - Enemy4
	
	.db $80,$15,$03,$90	;$0224 - Enemy5
	.db $60,$15,$03,$28	;$0228 - Enemy6

start_screen:	
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$71,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4a,$4b,$66,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$71,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5a,$5b,$66,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$70,$74,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$65,$72,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$60,$73,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$75,$62,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$71,$29,$2b,$1E,$2c,$2c,$02,$02,$2c,$2d,$1a,$2b,$2d,$66,$00,$00,$00,$00,$00,$00,$00,$00,$00
start_screen1:	
	.db $00,$00,$00,$00,$00,$00,$00,$00,$00,$70,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$72,$00,$00,$00,$00,$00,$00,$00,$00,$00

humanswin:			;$210B
	.db $60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62
	.db $71,$21,$2e,$26,$1a,$27,$2c,$02,$30,$22,$27,$66
	.db $70,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$72

alienswin:			;$210B
	.db $60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62
	.db $71,$1a,$25,$22,$1e,$27,$2c,$02,$30,$22,$27,$66
	.db $70,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$72


eradicated:			;210B
	.db $60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62
	.db $71,$02,$02,$21,$2e,$26,$1a,$27,$2c,$02,$02,$66
	.db $71,$1e,$2b,$1a,$1d,$22,$1c,$1a,$2d,$1e,$1d,$66
	.db $70,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$72

timeup:				;$210B;212B;214B
	.db $60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62
	.db $71,$02,$2d,$22,$26,$1e,$02,$2e,$29,$37,$02,$66
	.db $70,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$72

tie:				;$210B
	.db $60,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$62
	.db $71,$2d,$21,$1e,$02,$1f,$22,$20,$21,$2d,$02,$66
	.db $71,$26,$2e,$2c,$2d,$02,$20,$28,$02,$28,$27,$66
	.db $70,$63,$63,$63,$63,$63,$63,$63,$63,$63,$63,$72

	
timer_tens_buffer_top:
	.db $A5,$A5,$A4,$A4,$A3,$A3,$A2,$A2,$A1,$A1,$A0,$A0
timer_tens_buffer_bottom:
	.db $B5,$B5,$B4,$B4,$B3,$B3,$B2,$B2,$B1,$B1,$B0,$BA
timer_ones_buffer_top:
	.db $A9,$A8,$A7,$A6,$A5,$A4,$A3,$A2,$A1,$A0
timer_ones_buffer_bottom:
	.db $B9,$B8,$B7,$B6,$B5,$B4,$B3,$B2,$B1,$B0
score_ones_buffer_en:
	.db $91,$92,$93,$94,$95,$96,$97,$98,$99,$90
score_tens_buffer_en:
	.db $91,$92,$93,$94,$95,$96,$97,$98,$99,$90
score_ones_buffer_player:
	.db $91,$92,$93,$94,$95,$96,$97,$98,$99,$90
score_tens_buffer_player:
	.db $91,$92,$93,$94,$95,$96,$97,$98,$99,$90

top_bar:
	.db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
	.db $84,$85,$85,$85,$85,$85,$85,$85,$1a,$25,$22,$1e,$27,$2c,$85,$A6,$A0,$85,$29,$25,$1a,$32,$1e,$2b,$85,$85,$85,$85,$85,$85,$85,$86
	.db $9b,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9a,$90,$90,$90,$9c,$9c,$B6,$B0,$9c,$9c,$9a,$90,$90,$90,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9c,$9d
	;; #77 for Alien 000 ones - $604D
	;; #76 for Alien 000 tens - $604C
	;; #75 for Alien 000 hundreds - $604B
	;; #87 for Player 000 ones - $6057
	;; #86 for Player 000 tens - $6056
	;; #85 for Player 000 hundreds - $6055
	;; Ones place Top timer - $6031
	;; Tens place Top timer - $6030
	;; Tens place Bottom timer- $6050
	;; Ones place Bottom timer - $6051


En_Y1:
	.dw En1_LocY
En_X1:
	.dw En1_LocX

En_Y:
	.dw En1_LocY, En2_LocY, En3_LocY, En4_LocY
En_X:
	.dw En1_LocX, En2_LocX, En3_LocX, En4_LocX

En_Move_RTS_table:
	.dw four_ens-1

song_headers:
	.word song0_header  ;this is a silence song.  See song0.i for more details
	.word song1_header  ;start screen music - memphis blues
	.word song2_header  ;game music
	.word song3_header  ;player wins
	.word song4_header  ;timer up
	.word song5_header  ;enemy wins
	.word song6_header	;press start on start screen SFX
    
	.include "game/SE/note_table.asm" ;period lookup table for notes
	.include "game/SE/note_length_table.asm"
	.include "game/SE/song0.asm"  ;holds the data for song 0 (header and data streams)
	.include "game/SE/song1.asm"  ;holds the data for song 1
	.include "game/SE/song2.asm"
	.include "game/SE/song3.asm"
	.include "game/SE/song4.asm"
	.include "game/SE/song5.asm"
	.include "game/SE/song6.asm"









