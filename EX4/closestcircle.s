.text
.global closestCircle
.type closestCircle, "function"

closestCircle:	mov X15, X3  // guardar coisas (sem usar stack)
				mov W14, W2
point_loop:		cbz W0, end
				sub W0, W0, 1
				mov X3, X15  // voltar ao início do array de círculos
				mov W2, W14  // devolver o valor original a NC
				mov W9, 0  // indice círculos
				ldp S1, S0, [X1], 8
				ldp D3, D2, [X3], 16
				ldr D4, [X3], 8
				fcvt D0, S0
				fcvt D1, S1

				fsub D9, D0, D2
				fsub D10, D1, D3
				fmul D9, D9, D9
				fmul D10, D10, D10
				fadd D9, D9, D10
				fsqrt D9, D9
				fsub D5, D9, D4

				fmov D6, D5  // guardar atual "melhor" resultado, mesmo se for 0
				fcmp D5, #0.0
				b.ls skip1
				str W9, [X4]  // guardar índice se for uma distância válida
skip1:			sub W2, W2, 1
				add W9, W9, 1
c_loop:			cbz W2, point_back
				ldp D3, D2, [X3], 16
				ldr D4, [X3], 8

				fsub D9, D0, D2
				fsub D10, D1, D3
				fmul D9, D9, D9
				fmul D10, D10, D10
				fadd D9, D9, D10
				fsqrt D9, D9
				fsub D5, D9, D4

				fcmp D5, #0.0  // ignorar distâncias 0
				b.ls skip2
				fcmp D5, D6
				b.gt skip2
				fmov D6, D5  // guardar atual "melhor" resultado
				str W9, [X4]  // guardar índice
skip2:			sub W2, W2, 1
				add W9, W9, 1
				b c_loop

point_back:     add X4, X4, 4
				b point_loop


end: ret
