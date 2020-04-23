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
	;; |||||+---Pause
	;; ||||+----	
	
RIGHTWALL	= $F0  
TOPWALL     	= $20
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
;----------------------------------
; Enemy OAM Variables
;----------------------------------
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
;----------------------------------
; Player OAM Variables
;----------------------------------
shadow_oam		= $0200
playerax_r		= $0204
playerax_l		= $0208
playerax_u		= $020C
playerax_d		= $0210
;---------------------------------
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
ptr1			= $4A
	;; 		= $4B
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
seed3			= $5D
	;; 		= $5E
enemy_num_tablecheck	= $5F
	;; 		= $60
EnCounter		= $61
Temp_enemy_num		= $62	
En1_Tree_Count		= $63
EnPtr1			= $64
EnPtr2	 		= $65
EnCounter2		= $66
EnCounter3		= $67
EnCounter_Dec		= $68
EnBit			= $69
EnCounter_Dec2		= $6A
EnCounter_Dec3		= $6B
EnDec			= $6C
EnDownCounter		= $6D
EnUpCounter		= $6E
EnRightCounter		= $6F
EnLeftCounter		= $70
EnCounter_Dec4		= $71
EnCounter4		= $72
EnemyPointY		= $73
	;;		= $74
EnemyPointX		= $75
	;; 		= $76
OAM_Num			= $77
EnemyTrueFalse		= $78
PlayerTreeCount		= $79
EnemyTreeCount		= $7A
MapTreeCount		= $7B
P_Tree_Point		= $7C
	;; 		= $7D
A_Tree_Point		= $7E
	;; 		= $7F
Timer_Point		= $80	
	;; 		= $81
Timer			= $82
Timer_Dec		= $83
Timer_Ones_Top_Point	= $84
	;;		= $85
Timer_Ones_Bottom_Point	= $86
	;; 		= $87
Timer_Tens_Top_Point	= $88
	;; 		= $89
Timer_Tens_Bottom_Point	= $8A
	;; 		= $8B
UpdateTimer_Flag	= $8C
UpdateTimerTens_Flag	= $8D
UpdateTimerOnes_Flag	= $8E
Timer_Ones_Dec		= $8F	
Timer_Temp_Ones_Y	= $90
Timer_Temp_Tens_Y	= $91
PlayerTreeDraw_Flag	= $92
EnemyTreeDraw_Flag	= $93
Score_Ones_En_Point	= $94
	;; 		= $95
Score_Tens_En_Point	= $96
	;; 		= $97
Score_Hund_En_Point	= $98
	;; 		= $99
Score_Ones_Player_Point	= $9A
	;; 		= $9B
Score_Tens_Player_Point	= $9C
	;; 		= $9D
Score_Hund_Player_Point	= $9E
	;; 		= $9F
Score_Temp_Ones_Player	= $A0
Score_Temp_Tens_Player	= $A1
Score_Temp_Hund_Player	= $A2
Score_Temp_Ones_En	= $A3
Score_Temp_Tens_En	= $A4
Score_Temp_Hund_En	= $A5
Score_Ones_P_Dec	= $A6
Score_Tens_P_Dec	= $A7
Score_Hund_P_Dec	= $A8
Score_Ones_E_Dec	= $A9
Score_Tens_E_Dec	= $AA
Score_Hund_E_Dec	= $AB
whattile_player		= $AC
whattile_enemy		= $AD
Score_P_Ones_Flag	= $AE	
Score_P_Tens_Flag	= $AF
Score_P_Hund_Flag	= $B0
Score_E_Ones_Flag	= $B1	
Score_E_Tens_Flag	= $B2
Score_E_Hund_Flag	= $B3
Score_P_Tens_First_Flag = $B4
Score_P_Hund_First_Flag = $B5	;don't need?
Score_E_Tens_First_Flag = $B6
Score_E_Hund_First_Flag = $B7 ;don't need?
Timer_Out_Flag		= $B8	
Pre_Inc_Value_Tens	= $B9
Pre_Inc_Value_Ones	= $BA
Down_Flag		= $BB
Up_Flag			= $BC
TopWall_Flag		= $BD
sleeping		= $BE
dbuffer_index		= $BF

se_ptr1			= $C0
	;; 		= $C1
sound_ptr		= $C2
	;; 		= $C3
current_song		= $C4
startup_flag		= $C5
song_flag		= $C6
ax_x_temp		= $C7
ax_y_temp		= $C8
p_chopped_tree_flag	= $C9
s_y			= $CA
Timer_Out_Draw_Flag	= $CB
Draw_AliensWin_Flag	= $CC
Draw_HumansWin_Flag	= $CD
Draw_Tie_Flag		= $CE
Draw_TimerUp_Flag	= $CF
Draw_PlayerDeath_Flag	= $D0
Timer_Set_Flag		= $D1
Human_Set_Flag		= $D2
Alien_Set_Flag		= $D3
Tie_Set_Flag		= $D4	
	.enum $0300
sound_disable_flag	.dsb 1
sound_temp1		.dsb 1
sound_temp2		.dsb 1
sound_sq1_old		.dsb 1
sound_sq2_old		.dsb 1
soft_apu_ports		.dsb 16
	
stream_curr_sound	.dsb 6
stream_status		.dsb 6
stream_channel		.dsb 6
stream_ptr_LO		.dsb 6
stream_ptr_HI		.dsb 6
stream_vol_duty		.dsb 6
stream_note_LO		.dsb 6
stream_note_HI		.dsb 6
stream_tempo		.dsb 6
stream_ticker_total	.dsb 6
stream_note_length_counter .dsb 6
stream_note_length	.dsb 6
	.ende
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

