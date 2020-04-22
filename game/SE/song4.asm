song4_header:
	.byte $01           ;1 streams
	
	.byte SFX_2     ;which stream
	.byte $01           ;status byte (stream enabled)
	.byte SQUARE_2      ;which channel
	.byte $BC           ;initial volume (C) and duty (10)
	.word song4_square2 ;pointer to stream
	.byte $60           ;tempo
                        
song4_square2:
	.byte sixteenth, D3, Fs4, A5, D4, Fs5, A6, D5, Fs6, A7
	.byte sixteenth, D3, Fs4, A5, D4, Fs5, A6, D5, Fs6, A7
	.byte sixteenth, D3, Fs4, A5, D4, Fs5, A6, D5, Fs6, A7
	.byte $FF
