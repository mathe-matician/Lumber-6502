
	LDA #$78
	STA shadow_oam
	LDA #$01
	STA shadow_oam+1
	LDA #$00
	STA shadow_oam+2
	LDA #$78
	STA shadow_oam+3

	;; LDA #%00000001
	;; STA levels

Level_Logic:	

	LDA levels
	AND #%00000001
	CMP #%00000001
	BNE level_1

	;; AND #%00000010
	;; CMP #%00000010
	;; BEQ level_2

	;; AND #%0000010001
	;; CMP #%00000100
	;; BEQ level_3

	;; AND #%00001000
	;; CMP #%00001000
	;; BEQ level_4

	;; AND #%00010000
	;; CMP #%00010000
	;; BEQ level_5

level_1:	
	LDX #$34
	LDY #$00
trees_1:
	LDA level_1_buffer, y
	STA shadow_oam+4, y
	INY
	DEX
	CPX #$00
	BNE trees_1

	LDX #$04
	LDY #$00
Enemy_1_Ani:
	LDA level_1_enemy1, y
	STA $0228, y
	INY
	DEX
	CPX #$00
	BNE Enemy_1_Ani

;; level_2:	
;; 	LDX #$00
;; 	LDY #$00
;; trees_2:

;; 	LDA #$90
;; 	STA $0204
;; 	LDA #$02
;; 	STA $0205
;; 	LDA #$00
;; 	STA $0206
;; 	LDA #$90
;; 	STA $0207

;; 	JMP DoDrawingDone

;; level_3:	

;; trees_3:

;; 	JMP DoDrawingDone

;; level_4:	

;; trees_4:
	
;; 	JMP DoDrawingDone

;; level_5:	

;; trees_5:

;; 	JMP DoDrawingDone
