WaitFrame:

DoFrame:

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
	;; CMP #$00
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

PpuScroll:
	BIT $2002
	LDA #$00
	STA $2005		;ppu scroll - turn off
	STA $2005

	INC FrameCounter1

	jsr Player_Chop
	LDA PlayerTreeDraw_Flag
	BNE @test
	;; jsr Player_Chop
	JSR Update_Player_Score
	inc PlayerTreeDraw_Flag
@test:
	LDA UpdateTimer_Flag
	BNE @Continue 
	JSR Update_Timer_Ones
	INC UpdateTimer_Flag
@Check:
	LDA UpdateTimerTens_Flag
	BNE @Continue
	JSR Update_Timer_Tens
	INC UpdateTimerTens_Flag
@Continue:
	;; LDA PlayerTreeDraw_Flag
	;; BNE @Continue2
	;; jsr Player_Chop
	;; ;; inc PlayerTreeDraw_Flag
	;; JSR Update_Player_Score
	;; INC PlayerTreeDraw_Flag
@Continue2:
	lda EnemyTreeDraw_Flag
	BNE @Continue4
	JSR BreakTree
	JSR Update_Enemy_Score
	INC EnemyTreeDraw_Flag	
@Continue4:

	;; run music code after drawing
	jsr sound_play_frame
	
	JSR UpdateController
	
	LDA #$00
	STA draw_flags
	sta sleeping
	PullAll

	RTI


DoDrawing:


DoDrawingDone:	
	RTS
	
UpdateController:
	
	.include "game/controls.asm"
	;; .include "game/player_action.asm"
	LDA buttons1
	STA prev_button
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

	LDA prev_button
	EOR #$FF		;bitwise NOT
	AND buttons1
	STA new_button
	
	RTS
