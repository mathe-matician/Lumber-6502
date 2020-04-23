GameEngineRunning:
	;; inc game_running_flag
	lda #$02
	jsr sound_load
	dec UpdateTimer_Flag
Forever:
	inc sleeping
@loop:
	lda sleeping
	bne @loop

	jsr PlayerPunch
	
	LDA Timer_Out_Flag
	BEQ @Continue3
	JMP TimeUp
@Continue3:
	INC Timer
	BNE @Continue
	DEC UpdateTimer_Flag
	LDA #$D0
	STA Timer
@Continue:
	DEC EnCounter
	BNE Forever
	LDA #$02
	STA EnCounter
	JSR Enemy_Movement_Table
@Continue2:
	LDA #$16
	STA playerax_u+1
	STA playerax_d+1
	STA playerax_l+1
	STA playerax_r+1
	JMP Forever
	
	.include "game/deathcheck.asm"
	.include "game/timer.asm"
	.include "game/score.asm"
	.include "game/timeup.asm"
	.include "game/player_action.asm"
TimeUp:
	LDA #%00000010
	STA STATE
	;; JSR LoadTimeUpScreen
	inc Draw_TimerUp_Flag
@Wait:
	LDA FrameCounter1
	CMP #$80
	BNE @Wait
	LDA PlayerTreeCount
	CMP EnemyTreeCount
	BEQ @ScoreTie
	LDA PlayerTreeCount
	CMP EnemyTreeCount
	BCC @AliensWin
	;; JSR LoadHumansWin
	inc Draw_HumansWin_Flag
	JMP @Continue
@AliensWin:
	;; JSR LoadAliensWin
	inc Draw_AliensWin_Flag
	JMP @Continue
@ScoreTie:
	;; JSR LoadScoreTie
	inc Draw_Tie_Flag
@Continue:
	LDA FrameCounter1
	CMP #$01
	;; cmp #$40
	BNE @Continue
	LDA #$00
	STA $2001
	JMP TheStart
GameOver:
	LDA FrameCounter1
	CMP #$99
	BNE GameOver
	LDA #%00000000
	STA $2001
	JMP TheStart
