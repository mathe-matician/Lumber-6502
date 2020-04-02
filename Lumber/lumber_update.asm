	.include "variables.asm"
	.include "ines_header.asm"
	.include "banks.asm"
	
	.include "reset_load.asm"
	.include "macros.asm"
	
	.include "load_start_screen.asm"
	.include "startscreen_init.asm"
	.include "maptorom.asm"
	.include "lvl_1_init.asm"
	.include "prng_map.asm"
	
	.include "gameenginerunning.asm"
	.include "gameover.asm"
	
	.include "nmi.asm"
	
	.include "gettile.asm"
	.include "colorbuffers.asm"
	.include "levelbuffers.asm"
	
	.include "interrupts.asm"
	.include "chrrom.asm"
