.text
.global SelectedUpperCase
.type SelectedUpperCase, "function"

SelectedUpperCase:	mov W4, 0
			mov X5, 0
			loop0:	ldrb W2, [X1]
			cmp W2, 0
			b.eq fim
			loop1:	ldrb W3, [X0, X5]
				cmp W3, 0
				b.eq next_iter1
				cmp W3, W2
				b.eq next_iter0
				add X5, X5, 1
				b loop1
	   		next_iter0:  sub W3, W3, 32
	   			     strb W3, [X1]
	   			     add W4, W4, 1
	   		next_iter1:  mov X5, 0
	   			     add X1, X1, 1
				     b loop0
			fim:	mov W0, W4
				ret

