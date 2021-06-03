.text
.global CheckABS
.type CheckABS, "function"

CheckABS:	mov X3, 0
		mov W4, 0
		mov W6, 0
loop:		cbz W1, end
		ldr W5, [X2, X3]
		cmp W5, 0
		csneg W5, W5, W5, GE
		cmp W5, W0
		b.LE skip
		str W6, [X2, X3]
		add W4, W4, 1
skip:		add X3, X3, 4
		sub W1, W1, 1
		b loop
end:		mov W0, W4
		ret

