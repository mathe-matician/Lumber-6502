;------------------------------------------------;
; Lumber by Zach Mathe - 2020                    ;	
;------------------------------------------------;

	.include "vars/variables.asm"
	
	.include "init/nes/ines_header.asm"
	.include "init/nes/banks.asm"
	.include "init/nes/reset_load.asm"
	
	.include "init/game/macros.asm"
	.include "init/game/load_start_screen.asm"
	.include "init/game/startscreen_init.asm"
	.include "init/game/maptorom.asm"
	.include "init/game/lvl_1_init.asm"
	.include "init/game/prng_map.asm"
	
	.include "game/gameenginerunning.asm"
	.include "game/gameover.asm"
	
	.include "game/nmi.asm"
	
	.include "buffers/gettile.asm"
	.include "buffers/colorbuffers.asm"
	.include "buffers/levelbuffers.asm"
	
	.include "ender/interrupts.asm"
	.include "ender/chrrom.asm"
