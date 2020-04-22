song5_header:
	.byte $01           ;1 stream
	
	.byte MUSIC_SQ2         ;which stream
	.byte $01           ;status byte (stream enabled)
	.byte SQUARE_2      ;which channel
	.byte $7F           ;initial volume (F) and duty (01)
	.word song5_square2 ;pointer to stream
	.byte $80           ;tempo
    
    
song5_square2:
	.byte eighth, B4, Fs4, D4, Cs4, E4, D4, Cs4, B3
	.byte $FF
