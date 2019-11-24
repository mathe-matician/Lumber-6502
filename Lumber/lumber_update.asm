;----------------------------------------------------------------
; constants
;----------------------------------------------------------------

PRG_COUNT = 1 ;1 = 16KB, 2 = 32KB
MIRRORING = %0001 ;%0000 = horizontal, %0001 = vertical, %1000 = four-screen

STATETITLE	= $00
;; STATEPLAYING	= $05
;; STATEGAMEOVER	= $06
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
z_Regs 			= $20
H			= z_Regs
L			= z_Regs+1
	
shadow_oam		= $0200	
FrameCounter1		= $04
FrameCounter2		= $03
FrameCounter3		= $05
FrameCounter4		= $06	
Level_1_Enemies 	= $60
fake_player		= $10
temp_player_x_move	= $11
temp_player_y_move	= $12	
	
   .enum $0000

   ;NOTE: declare variables using the DSB and DSW directives, like this:

	;MyVariable0 .dsb 1
;; fake_player		.dsb 1
gamestate  		.dsb 1	
buttons1  		.dsb 1
buttons2  		.dsb 1
levels			.dsb 1
	;;draw_flag bits:
	;;00000000
	;;|||||||+-level 1
	;;||||||+--level 2
	;;|||||+---level 3
	;;||||+----level 4
	;;|||+-----level 5

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

GameEngineRunning:

	LDA #$00
	STA fake_player
	
	;; can put this somehwere else and also in a buffer.
	LDA #$78
	STA shadow_oam
	LDA #$01
	STA shadow_oam+1
	LDA #$00
	STA shadow_oam+2
	LDA #$78
	STA shadow_oam+3

	;; LDA shadow_oam_y
	;; STA fake_shadow_oam

	;; init variables
	LDA #$FF
	STA FrameCounter1
	STA FrameCounter2
	STA FrameCounter3
	TAX

	LDA #$01
	STA Level_1_Enemies

	LDA #%00000001
	STA levels
	
	LDA #%00000110 ;draw sprites
	STA draw_flags
Forever:
	.include "level_animations.asm"
	JMP Forever
	
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
	JSR UpdateController

	LDA #$00
	STA draw_flags
	PullAll

	RTI


DoDrawing:

	.include "levels.asm"

DoDrawingDone:	
	RTS
	
UpdateController:
	.include "controls.asm"
	
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
