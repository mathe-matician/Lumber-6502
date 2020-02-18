sound_init:	
	LDA #$0F
	STA $4015		;enable Square 1, 2, Triangle & Noise channels

	LDA #$30
	;; #%00110000
	;; Bits 6,7 - Set duty cycle to 00 (weak grainy tone 12.5 Duty)
		;;Duty refers to the percentage of time the wave is "up" vs. "down" 
	;; Bits 5,4 - Disable internal length & volume counters (gives us more control)
	;; Bits 0,1,2,3 - VOLUME
	STA $4000		;square 1	-|
	STA $4004		;square 2	-|- bits 0-5 the same
	STA $400C		;noise channel	-| 
	LDA #$80		;disable triangle counters
	STA $4008		;triangle

	LDA #$00
	STA sound_disable_flag	;clear disable flag

	;; other variable init will go here if needed

	RTS

sound_disable:
	LDA #$00
	STA $4015		;disable all channels
	LDA #$01
	STA sound_disable_flag	;set disable flag

	RTS

sound_load:

	RTS

sound_play_frame:
	LDA sound_disable_flag
	BNE @done 		;if disable flag is set, don't advance a frame
	;; code if not set
@done:
	RTS
