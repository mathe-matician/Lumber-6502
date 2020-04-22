song3_header:
	.byte $01           ;4 streams
    
	.byte MUSIC_SQ1     ;which stream
	.byte $01           ;status byte (stream enabled)
	.byte SQUARE_1      ;which channel
	.byte $BC           ;initial volume (C) and duty (10)
	.word song3_square1 ;pointer to stream
	.byte $80           ;tempo
    
song3_square1:
	.byte eighth, D5, E5, Fs5, G5, Fs5, G5, A5, Cs5, D6, E6, D6, D6, D6
	.byte $FF
