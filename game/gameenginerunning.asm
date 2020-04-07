GameEngineRunning:

	LDA #$00
	STA EnPoint1Y+0
	STA EnPoint1Y+1
	STA EnPoint1X+0
	STA EnPoint1X+1
	STA seed3+0
	STA seed3+1
	STA EnCounter

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
	LDA EnCounter
	CLC
	ADC #$01
	STA EnCounter
	JSR PlayerDeathCheck1
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
