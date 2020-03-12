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

	MACRO Chop ax_y, ax_x, function, ptr1, ptr2, offset
		LDA ax_x
		LDX ax_y
		JSR function
		;; CMP #$04
		;; BNE ChopDone
		LDA ax_x	;x coordinate
		LDX ax_y	;y coordinate
	;; divide x coordinate by 8 and store x-offset in variable
		lsr
		lsr
		lsr
		STA offset
		;; zero out Z+1 and get the lower bits
		lda #$00
		sta ptr2+1
		txa
		and #%11111000
		;; multiply y coordinate by 32
		asl
		rol ptr2+1
		asl
		rol ptr2+1
		;add the result to the base address of the NT
		adc ppu_base+0
		sta ptr2+0
		lda ptr2+1
		adc ppu_base+1
		sta ptr2+1
		;; add 
		LDA ptr2+0
		CLC
		ADC offset
		STA ptr2+0
		;; update PPU
		LDA $2002
		LDA ptr2+1
		STA $2006
		LDA ptr2+0
		STA $2006
		LDA #$00
		STA $2007
		STA $2005
		STA $2005
	
ChopDone:
	ENDM

	MACRO PlayerDeathCheck enemyy, enemyx, playery, playerx
		LDA enemyy
		CMP playery
		BNE DeathCheckDone
		
		LDA enemyx
		CMP playerx
		BNE DeathCheckDone
		
		LDA #$03
		STA shadow_oam+2
		LDA #%00000010
		STA STATE
DeathCheckDone:		
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
	
		LDA S1
		CLC
		ADC #$05
		STA S1
	ENDM

