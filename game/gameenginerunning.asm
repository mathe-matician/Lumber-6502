GameEngineRunning:
	DEC UpdateTimer_Flag
Forever:
	inc sleeping
@loop:
	lda sleeping
	bne @loop
	
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
	LDA EnemyTreeDraw_Flag
	BNE @Continue2
	JSR Update_Enemy_Score
	INC EnemyTreeDraw_Flag
	
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

TimeUp:
	LDA #%00000010
	STA STATE
	JSR LoadTimeUpScreen
	LDA FrameCounter1
	CMP #$80
	BNE TimeUp
	LDA PlayerTreeCount
	CMP EnemyTreeCount
	BEQ @ScoreTie
	CMP EnemyTreeCount
	BCC @AliensWin
	JSR LoadHumansWin
	JMP @Continue
@AliensWin:
	JSR LoadAliensWin
	JMP @Continue
@ScoreTie:
	JSR LoadScoreTie
@Continue:
	LDA FrameCounter1
	CMP #$01
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
