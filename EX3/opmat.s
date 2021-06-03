.text
.global OpMat
.type OpMat, "function"

OpMat:	        stp X29, X30, [SP, -48]!
		mov X29, SP

		// passar tudo para outros registos
		mov W9, W0    // 1
		mov W10, W1   // 1
		mov X11, X2   // 8
		mov X12, X3   // 8

		mov W15, -1  // resultado da última 'O'

		// guardar coisas na pilha
		str X12, [X29, 16]
		str X11, [X29, 24]
		strb W10, [X29, 32]
		strb W9, [X29, 33]

loop:	ldrb W4, [X11]
	cbz W4, fim
	cmp W4, 88
	b.eq fim
	cmp W4, 76
	b.eq L
	cmp W4, 67
	b.eq C
	cmp W4, 80
	b.eq P
	cmp W4, 66
	b.eq B
	cmp W4, 79
	b.eq O

fim:	mov W0, W15
	ldp X29, X30, [SP]
	add SP, SP, 48
	ret

L:	add X11, X11, 1
	ldrb W0, [X11]
	add X11, X11, 1
	ldrb W1, [X11]
	mul W0, W0, W9
l_loop: cbz W9, l_end
	strb W1, [X12, X0]
	add X12, X12, 1
	sub W9, W9, 1
	b l_loop
l_end:  ldr X12, [X29, 16]   // trazer valor de volta da pilha
	ldrb W9, [X29, 33]  //       ""             ""
	add X11, X11, 1  // preparar X11 para encontrar a próxima letra na sequência
	b loop


C:	add X11, X11, 1
	ldrb W0, [X11]
	add X11, X11, 1
	ldrb W1, [X11]
	mov X3, X9
c_loop: cbz W9, c_end
	strb W1, [X12, X0]
	sub W9, W9, 1
	add X0, X0, X3
	b c_loop
c_end:  mov W9, W3  // ir buscar W9 (neste caso já estava em W3)
	add X11, X11, 1  // preparar X11 para encontrar a próxima letra na sequência
	b loop


P:	add X11, X11, 1
	ldrb W0, [X11]
	add X11, X11, 1
	ldrb W1, [X11]
	add X11, X11, 1
	ldrb W2, [X11]
	umaddl X3, W1, W9, X0
	strb W2, [X12, X3]
	add X11, X11, 1
	b loop

B:	mul W0, W9, W10
	mov X1, 0
	add X11, X11, 1
b_loop: cmp W0, W1
	b.eq loop
	ldrb W2, [X12, X1]
	cmp W2, 127
	b.le down
	b up

done:   strb W2, [X12, X1]
	add W1, W1, 1
	b b_loop

down: mov W2, 0
      b done
up: mov W2, 255
    b done


O:	add X11, X11, 1
	ldrb W0, [X11]
	mov X1, X12
	mul W2, W9, W10
	str X11, [X29, 24]  // guardar X11 correto na pilha
	bl ocorr
	mov W15, W0  // resultado de ocorr guardado

	// tudo de volta
	ldr X12, [X29, 16]
	ldr X11, [X29, 24]
	ldrb W10, [X29, 32]
	ldrb W9, [X29, 33]

	add X11, X11, 1
	b loop
