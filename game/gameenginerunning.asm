GameEngineRunning:

	LDA #$00
	STA EnPoint1Y+0
	STA EnPoint1Y+1
	STA EnPoint1X+0
	STA EnPoint1X+1
	STA EnCounter2
	STA EnCounter3
	STA EnCounter4
	STA EnBit
	LDA EnemyTrueFalse

	LDA #$40
	STA EnCounter

	;; LDA #$02
	LDA #$01
	STA EnCounter_Dec
	STA EnCounter_Dec2
	STA EnCounter_Dec3
	STA EnCounter_Dec4

	LDA #$03
	STA EnDec
	LDA #$04
	STA EnDownCounter
	STA EnUpCounter
	STA EnRightCounter
	STA EnLeftCounter

	LDA #$03
	STA seed3+0
	LDA #$05
	STA seed3+1

	LDA #$CC
	STA hi
	LDA #$33
	STA lo

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

	JSR PlayerDeathCheck1
	
	DEC EnCounter
	BNE Forever
	LDA #$80
	STA EnCounter
	JSR Enemy_Movement_Table
	
	JMP Forever

	.include "game/deathcheck.asm"
	
GameOver:
	LDA FrameCounter1
	CMP #$88
	BNE GameOver
	LDA #%00000000
	STA $2001
	JMP TheStart
