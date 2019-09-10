;----------------------------------------------------------------
; constants
;----------------------------------------------------------------

PRG_COUNT = 1 ;1 = 16KB, 2 = 32KB
MIRRORING = %0001 ;%0000 = horizontal, %0001 = vertical, %1000 = four-screen

STATETITLE	= $00
STATEPLAYING	= $01
STATEGAMEOVER	= $02

;----------------------------------------------------------------
; variables
;----------------------------------------------------------------
oam 	  	= $0200 ;shadow oam
draw_flags 	= #%00000000
	;;draw_flag bits:
	;;00000000
	;;|||||||+-needma
	;;||||||+--needdraw
	;;|||||+---needppureg
	;;||||+----2000
	;;|||+-----2001

	;; fake registers in zero page
z_Regs 		= $60
z_HL		= z_Regs
z_H		= z_Regs
z_L		= z_Regs+1
z_DE		= z_Regs+2
z_D		= z_Regs+2
z_E		= z_Regs+3
shadow_oam	= $0200	
	
   .enum $0000

   ;NOTE: declare variables using the DSB and DSW directives, like this:

   ;MyVariable0 .dsb 1
   ;MyVariable1 .dsb 3

gamestate  	.dsb 1	
buttons1  	.dsb 1
buttons2  	.dsb 1
temp		.dsb 1	

   .ende

   ;NOTE: you can also split the variable declarations into individual pages, like this:

   ;.enum $0100
   ;.ende

   ;.enum $0200
   ;.ende

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

	LDA #%00000010 ;draw sprites
	
Forever:
	JMP Forever
	
WaitFrame:
	;; LDA #%00000000
	BIT $2002
	BPL WaitFrame
	RTS
;; 	inc sleeping
;; loop:
;; 	lda sleeping
;; 	bne loop
;; 	rts

   ;--------------------------------------
   ; DoFrame - same idea as WaitFrame, but also does some other stuff
   ;   that the game logic will want done every frame.  Things that
   ;   shouldn't be put in NMI

DoFrame:
	;; bit flags instead of variables?
	LDA #%00000100 ;NeedPpuReg
	STA draw_flags
	;; lda #1
	;; sta needdraw
	;; sta needoam
	;; sta needppureg
	jsr WaitFrame
	jsr UpdateJoypadData
	RTS
;---------------------------------------
; NMI
;---------------------------------------
NMI:

	PushAll

	
	;; LDA draw_flags
	;; AND #%00000001
	;; CMP #$00
	;; BEQ NeedDraw
	;; LDA #$00
	;; STA $2003
	;; LDA #>oam
	;; STA $4014
	
	;; LDA needma
	;; BEQ NeedDraw
	;; LDA #$00
	;; STA $2003
	;; LDA #>oam
	;; STA $4014

NeedDraw:
	LDA #$00
	STA $2003
	LDA shadow_oam ;$0200
	STA $4014
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

	;; LDA #$00
	;; STA draw_flags

	;; 9)pull registers/status flags off stack
	PullAll

	RTI


DoDrawing:
	;;  why does this only show up at 00 on the screen?
	LDA $80
	STA $0200
	LDA $01
	STA $0201
	LDA $00
	STA $0202
	LDA $80
	STA $0203

	RTS

	
;; 	LDY #$00
;; 	LDX #$00
;; 	LDA spritebuffer
;; 	STA z_H
;; 	DEC z_H
;; Looper:
;; 	INX
;; 	LDA spritebuffer, x
;; 	STA $0200, y
;; 	INY
;; 	DEC z_H
;; 	LDA z_H
;; 	BNE Looper
	
;; 	RTS
	
;; 	LDX #$00
;; 	LDY #$00
;; 	LDA spritebuffer
;; 	TAX
;; 	DEY
;; OuterLoop:	
;; 	LDA testbuffer, Y
;; 	CPX spritebuffer
;; 	BNE OuterLoop ;if not 0 go to outerloop
	
;; 	DEY
;; 	CPY #$00
;; 	BEQ DoDrawingDone	
;; 	LDA testbuffer, Y
;; 	STA $2006
;; 	INX
;; 	LDA testbuffer, Y
;; 	STA $2006
;; 	INX
;; 	;X should be at #$03 right now (in bytes to load)
;; BuffLoop:	
;; 	LDA testbuffer, X
;; 	STA $2007
;; 	INX
;; 	CPX bufflength
;; 	BNE BuffLoop
;; DoDrawingDone:
;; 	LDA #$00
;; 	STA draw_flags ;reset draw_flags to 0.
	;; RTS
UpdateJoypadData:
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

testbuffer:
	.db $07,$20,$00,$00,$01,02,03

spritebuffer:
	.db $05,$80,$01,$00,$80

	.include "colorbuffers.asm"

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
