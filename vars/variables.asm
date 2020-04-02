;----------------------------------------------------------------
; constants
;----------------------------------------------------------------

PRG_COUNT = 1 ;1 = 16KB, 2 = 32KB
MIRRORING = %0001 ;%0000 = horizontal, %0001 = vertical, %1000 = four-screen

STATE		= $13
	;; 00000000
	;; ||||||||-Title Screen
	;; |||||||+-Playing Game
	;; ||||||+--Gameover
	;; |||||+---Text Box
	;; ||||+----	
	
RIGHTWALL	= $F0  
TOPWALL     	= $18
BOTTOMWALL  	= $D8
LEFTWALL    	= $08	

;----------------------------------------------------------------
; variables
;----------------------------------------------------------------
	;; oam 	  	= $0200 ;shadow oam
draw_flags 	= #%00000000
	;;draw_flag bits:
	;;00000000
	;;|||||||+-needma
	;;||||||+--needdraw
	;;|||||+---needppureg
	;;||||+----2000
	;;|||+-----2001
lvl1_npc_flags	= $14
	;;0000 0000
	;;|  | |__|-NPC1z
	;;|  | ||||-False - zero
	;;|  | |||+-True
	;;|  | ||+--Text box active
	;;|  |
	;;|__|------NPC2
	;;|||+------False - use zero as well (take this out as false)
	;;||+-------True
playerfacing	= $16	
	;;00000000
	;;|||||||+--Right
	;;||||||+---Left
	;;|||||+----Down
	;;||||+-----Up
sevenblock	= $17
	;;00000000
	;;|||||||+-41 Left
	;;||||||+--41 Up
z_Regs 			= $20
H			= z_Regs
L			= z_Regs+1

zm_Regs			= $25
Z			= zm_Regs
M			= zm_Regs+1	

En1_LocY		= $0214
En2_LocY		= $0218
En3_LocY		= $021C
En4_LocY		= $0220
En5_LocY		= $0224
En6_LocY		= $0228
En7_LocY		= $022C
En8_LocY		= $0230
En9_LocY		= $0234
En10_LocY		= $0238
En11_LocY		= $023C
En12_LocY		= $0240	

En1_LocX		= En1_LocY+3
En2_LocX		= En2_LocY+3
En3_LocX		= En3_LocY+3
En4_LocX		= En4_LocY+3
En5_LocX		= En5_LocY+3
En6_LocX		= En6_LocY+3
En7_LocX		= En7_LocY+3	
En8_LocX		= En8_LocY+3
En9_LocX		= En9_LocY+3
En10_LocX		= En10_LocY+3
En11_LocX		= En11_LocY+3	
En12_LocX		= En12_LocY+3	

shadow_oam		= $0200
playerax_r		= $0204
playerax_l		= $0208
playerax_u		= $020C
playerax_d		= $0210	
FrameCounter1		= $0A
FrameCounter2		= $03
FrameCounter3		= $05
FrameCounter4		= $06	
Level_1_Enemies 	= $60
fake_player		= $10
temp_player_x_move	= $11
temp_player_y_move	= $12
fake_en_1		= $21	
temp_en_x_move		= $22
temp_en_y_move		= $23
en1_bitflag		= $27	
	;;00000000
	;;|||||||+-Up
	;;||||||+--Down
	;;|||||+---Right
	;;||||+----Left
enn1_check		= $28
en1_direction		= $29	
enemy_position		= $30
en2_direction		= $31
seed			= $32
	;; 		= $33
sound_disable_flag	= $34
S			= $35
Q			= $36
lo			= $37
hi			= $38
resultlo		= $39
resulthi		= $3A
BG256			= $3B
Pointer			= $3C
	;; 		= $3D
bg_ptr			= $0600
Point			= $45
	;; 		= $46
PRGROM			= $6000	;where tile map is stored
PRGROM1			= $6100
PRGROM2			= $6200
PRGROM3			= $6300	
VRAMADDR		= $47
tilenum			= $49
VRAM_LO			= $4A
VRAM_HI			= $4B
VRAM			= $2000
offset			= $4C
prev_button		= $4D
new_button		= $4E
seed2			= $4F
	;; 		= $50
enemy_num		= $51
BG_256			= $52
BGCount			= $53
PRGtest			= $54
EnPoint1Y		= $55
	;; 		= $56
EnPoint1X		= $57
	;; 		= $58
EnPoint2Y		= $59
	;; 		= $5A
EnPoint2X		= $5B
	;; 		= $5C

;-----------------------------------------
; Audio - Note Variables
;-----------------------------------------

	;; Octave1
A1			= $0300
As1			= $0301
Bb1			= $0301
B1			= $0302
	;; Octave2
C2			= $0303
Db2			= $0304
D2			= $0305
Eb2			= $0306
E2			= $0307
F2			= $0308
Gb2			= $0309
G2			= $030A
A2			= $030B
Ab2			= $030C
A2			= $030D
Bb2			= $030E
B2			= $030F
	;; Octave3
C3			= $0310
Db3			= $0311
D3			= $0312
Eb3			= $0313
E3			= $0314
F3			= $0315
Gb3			= $0316
G3			= $0317
A3			= $0318
Ab3			= $0319
A3			= $031A
Bb3			= $031B
B3			= $031C
	;; Octave4
C4			= $031D	;middle C
Db4			= $031E
D4			= $031F
Eb4			= $0320
E4			= $0321
F4			= $0322
Gb4			= $0323
G4			= $0324
A4			= $0325
Ab4			= $0326
A4			= $0327
Bb4			= $0328
B4			= $0329	
	
	
   .enum $0000

gamestate  		.dsb 1
;; BG256			.dsb 1	
buttons1  		.dsb 1
	;;00000000
	;;|||||||+--Right
	;;||||||+---Left
	;;|||||+----Down
	;;||||+-----Up
	;;|||+------Start
	;;||+-------Select
	;;|+--------B
	;;+---------A
buttons2  		.dsb 1
levels			.dsb 1
	;;draw_flag bits:
	;;00000000
	;;||||||||-start screen
	;;|||||||+-level 1
	;;||||||+--level 2
	;;|||||+---level 3
	;;||||+----level 4
	;;|||+-----level 5
	;;||+------dead reset

	;; to save space, could put collidebits into levels bit, but could be confusing.
collidebits			.dsb 1
	;;draw_flag bits:
	;;00000000
	;;||||||||-zero - open tile
	;;|||||||+-tree
	;;||||||+--fire/gold
	;;|||||+---enemy
	;;||||+----
	;;|||+-----
   .ende
