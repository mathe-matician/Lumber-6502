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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
