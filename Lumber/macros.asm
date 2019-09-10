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

	.macro setAXY x,y,z
	LDA #x
	LDX #y
	LDY #z
	.endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
