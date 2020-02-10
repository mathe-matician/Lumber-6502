	.macro PushAll
		PHP
		PHA
		TXA
		PHA
		TYA
		PHA
	.endm

	.macro PullAll
		PLA
		TAY
		PLA
		TAX
		PLA
		PLP
	.endm

	MACRO TileTranslate Reg1, Reg2, spritey, spritex, buffer
		LDA #$00
		STA Reg2
		LDA spritey
		AND #%11111000
		ASL
		ROL Reg2
		ASL
		ROL Reg2
		ADC #<buffer
		STA Reg1
		LDA Reg2
		ADC #>buffer
		STA Reg2
		LDA spritex
		LSR
		LSR
		LSR	
		TAY
		LDA (Reg1), Y
	ENDM

	MACRO PlayerDeathCheck enemyy, enemyx, playery, playerx
		LDA enemyy
		CMP playery
		BNE Abso_Done
		
		LDA enemyx
		CMP playerx
		BNE Abso_Done
		
		LDA #$03
		STA shadow_oam+2
Abso_Done:	
		;; LDA %00000010
		;; STA STATE
		
	ENDM

	MACRO PRNG S1
		LDY #$08		;iteration count (generates 8 bits)
		LDA S1+0
Seed1:
		ASL
		ROL S1+1
		BCC Seed2
		EOR #$39		;apply XOR feedback whenever a 1 bit is shifted out
Seed2:
		DEY
		BNE Seed1
		STA S1+0
		CMP #$00		;reload flags
	ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
