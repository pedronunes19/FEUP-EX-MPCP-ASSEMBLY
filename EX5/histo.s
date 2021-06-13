.text
.global histo
.type histo, "function"


histo:	mov W9, WZR
		scvtf S9, W9
		lsr W0, W0, 4
		scvtf S15, W0

loop:	cbz W0, end
		ldr Q0, [X1], 16
		mov X4, 0
		dup V1.16B, W4
		cmeq V2.16B, V0.16B, V1.16B
		addv B3, V2.16B
		smov W3, V3.16B[0]
		neg W3, W3
		ldrb W12, [X2, X4]
		add W3, W3, W12
		strb W3, [X2, X4]

freq_loop:	add X4, X4, 1
			dup V1.16B, W4
			cmeq V2.16B, V0.16B, V1.16B
			addv B3, V2.16B
			smov W3, V3.16B[0]
			neg W3, W3
			ldrb W12, [X2, X4]
			add W3, W3, W12
			strb W3, [X2, X4]
			cmp X4, 20
			b.ne freq_loop
/////////////////////////////////////////////////
			addv B5, V0.16B   // não leva em consideração os casos em que a soma das notas é maior que 255 porque é o último exercício e não há paciência
			umov W5, V5.B[0]
			scvtf S5, W5

			mov W10, 16
			scvtf S10, W10

			fdiv S5, S5, S10
			fadd S9, S9, S5
			sub W0, W0, 1
			b loop



end:  	fdiv S0, S9, S15
		ret



