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
	
RIGHTWALL	= $F0  ; when ball reaches one of these, do something
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

Lvl1_En1_Loc		= $021C
Lvl1_En2_Loc		= $0220	

shadow_oam		= $0200	
FrameCounter1		= $0A
FrameCounter2		= $03
FrameCounter3		= $05
FrameCounter4		= $06	
Level_1_Enemies 	= $60
fake_player		= $10
temp_player_x_move	= $11
temp_player_y_move	= $12
fake_en_1		= $21	
temp_en2_x_move		= $22
temp_en2_y_move		= $23
en1_bitflag		= $27	
	;;00000000
	;;|||||||+-Up
	;;||||||+--Down
	;;|||||+---Right
	;;||||+----Left
enn1_check		= $28
en1_direction		= $29
temp_en1_x_move		= $2A
temp_en1_y_move		= $2B	
enemy_position		= $30
en2_direction		= $31
seed			= $32
	;; 		= $33

	
   .enum $0000

   ;NOTE: declare variables using the DSB and DSW directives, like this:

	;MyVariable0 .dsb 1
;; fake_player		.dsb 1
gamestate  		.dsb 1
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

;----------------------------------------------------------------
; iNES header
;----------------------------------------------------------------

   .db "NES", $1a ;identification of the iNES header
   .db PRG_COUNT ;number of 16KB PRG-ROM pages
   .db $01 ;number of 8KB CHR-ROM pages
   .db $00|MIRRORING ;mapper 0 and mirroring
   .dsb 9, $00 ;clear the remaining bytes

;----------------------------------------------------------------
; program bank(s)
;----------------------------------------------------------------

	.base $10000-(PRG_COUNT*$4000)

	.include "reset_load.asm"
	.include "macros.asm"
	.include "load_start_screen.asm"

StartScreen:
	
	LDA #$00		;start screen
	STA levels
	STA STATE
	STA lvl1_npc_flags

	LDA #%00011110
	STA draw_flags
	
StartLoop:
	LDA STATE
	AND #%00000001
	BEQ StartLoop

	.include "lvl_1_init.asm"
Load_Lvl1:	
	.include "lvl_1.asm"

GameEngineRunning:	

	LDA #$00
	STA enn1_check

	LDA #$FF
	STA FrameCounter4
	STA FrameCounter3
	STA FrameCounter2

	LDA %00000001
	STA en1_direction
	LDY #$00
	STY enemy_position

	LDA #$11
	STA seed+0
	LDA #$05
	LDA seed+1
	
Forever:
		
	.include "lvl_1_enemy.asm"

	LDA STATE
	CMP %00000010
	BNE ForeverLoop
	JMP GameOver
	
ForeverLoop:	
	;; LDA lvl1_npc_flags
	;; AND #%00000001
	;; BNE To_Npc1

	;; LDA lvl1_npc_flags
	;; AND #%00000100
	;; BNE Npc_Check1	
	
	JMP Forever

GameOver:
	.include "gameover.asm"
	JMP GameOver

To_Npc1:
	JSR Lvl1_npc_text1

	JMP Forever
	
Npc_Check1:	
	LDA #$00
	STA lvl1_npc_flags
	JMP Load_Lvl1
	
Npc_Check_Done:	
	JMP Forever

;; Lvl1_npc2_text1:
;; 	;; JMP Load_Lvl1 		;temp fix

;; Lvl1_npc2_text1_loop:

;; 	LDA $2002
;; 	LDA #$21
;; 	Sta $2006
;; 	LDA #$00
;; 	STA $2006
	
;; Lop:	
;; 	LDA #$00, Y
;; 	STA $2007
;; 	INY
;; 	INX
;; 	CPX #$00
;; 	BNE Lop

;; 	LDA #%00001110
;; 	STA $2001
;; 	RTS			;DONT NEED RTS - take out when fixed

	
Lvl1_npc_text1:

;; 	LDA lvl1_npc_flags
;; 	AND #%00000011
;; 	CMP #%00000011
;; 	BNE Npc1_Load_Text

;; 	LDA #$00
;; 	STA lvl1_npc_flags
	
;; 	JMP Load_Lvl1

;; Npc1_Load_Text:	
	BIT $2002
	BPL Lvl1_npc_text1

	;; LDA #%00000100
	;; STA STATE
	
	LDA #%00000000
	STA $2001
	
	LDA $2002
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
	LDY #$00
Npc1_text1:	
	LDA Lvl_1_npc_1_1, Y
	STA $2007
	Iny
	INX
	CPX #$00
	BNE Npc1_text1

	LDA $2002
	LDA #$21
	STA $2006
	LDA #$00
	STA $2006
	
	LDX #$00
	LDY #$00
Npc1_text1_1:
	LDA Lvl_1_npc_1_2, Y
	STA $2007
	INY
	INX
	CPX #$00
	BNE Npc1_text1_1

	LDA $2002
	LDA #$22
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
	LDY #$00
Npc1_text1_2:
	LDA Lvl_1_npc_1_3, Y
	STA $2007
	INY
	INX
	CPX #$00
	BNE Npc1_text1_2

	LDA $2002
	LDA #$23
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
	LDY #$00
Npc1_text1_3:
	LDA Lvl_1_npc_1_4, Y
	STA $2007
	INY
	INX
	CPX #$00
	BNE Npc1_text1_3

	LDA #$00
	STA lvl1_npc_flags
	LDA #%00000010
	STA lvl1_npc_flags

	LDA #$00
	STA sevenblock

	LDA #%00001110
	STA $2001

Lvl1_npc1_done:	
	RTS
	
WaitFrame:
	;; LDA #%00000000
	;; BIT $2002
	;; BPL WaitFrame
	;; RTS
;; 	inc sleeping
;; loop:
;; 	lda sleeping
;; 	bne loop
;; 	rts

DoFrame:
	;; bit flags instead of variables?
	;; LDA #%00000110 ;NeedPpuReg
	;; STA draw_flags
	;; jsr WaitFrame
	;; jsr UpdateJoypadData
	;; RTS
;---------------------------------------
; NMI
;---------------------------------------
NMI:

	PushAll
	LDA #$00
	STA $2003
	LDA #$02
	STA $4014

	;; LDA STATE
	;; AND %00000010
	;; JMP GameOver

NeedDraw:
	LDA draw_flags
	AND #%00000010
	CMP #$00
	BEQ NeedPpuReg
	BIT $2002
	JSR DoDrawing
NeedPpuReg:
	LDA draw_flags
	AND #%00000100
	CMP #$00
	BEQ PpuScroll
	LDA draw_flags
	EOR #%00000100
	STA draw_flags
	LDA #%00011110
	STA $2001

	;; need to change something above with adding logic to turn screen off for a redraw...

PpuScroll:
	BIT $2002
	LDA #$00
	STA $2005		;ppu scroll - turn off
	STA $2005

	;; Optional
	;; 7)run music code
	;; 8)wait for sprite 0 hit and change the VRAM address
	;; Optional

	;; LDA #0 ;reset sleeping to 0 so WaitFrame exits
	;; STA sleeping
	LDA FrameCounter1
	CLC
	ADC #$01
	STA FrameCounter1
	
	JSR UpdateController

	LDA #$00
	STA draw_flags
	PullAll

	RTI


DoDrawing:
	;; LDA #$78
	;; STA shadow_oam
	;; LDA #$01
	;; STA shadow_oam+1
	;; LDA #$00
	;; STA shadow_oam+2
	;; LDA #$78
	;; STA shadow_oam+3

	;; .include "levels.asm"

DoDrawingDone:	
	RTS
	
UpdateController:
	
	PlayerDeathCheck Lvl1_En1_Loc, Lvl1_En1_Loc+3, shadow_oam, shadow_oam+3
	.include "lvl1enemy.asm"
	
	.include "controls.asm"	
	;; JSR Control_State
	
	LDA #$01
	STA $4016
	LDA #$00
	STA $4016
	LDX #$08
ReadController1Loop:
	LDA $4016
	LSR A            ; bit0 -> Carry
	ROL buttons1     ; bit0 <- Carry
	DEX
	BNE ReadController1Loop
	RTS

	;; .include "controls.asm"
	.include "colorbuffers.asm"
	.include "levelbuffers.asm"

;----------------------------------------------------------------
; interrupt vectors
;----------------------------------------------------------------

   .org $fffa

   .dw NMI
   .dw RESET
   .dw 0

;----------------------------------------------------------------
; CHR-ROM bank
;----------------------------------------------------------------

   .incbin "gamer.chr"
