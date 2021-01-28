section .text
	extern _printf2
	;global _main
	extern _max_array

_max_array: 
	
	mov ecx, [esp+4] ; 1 argument - ref to array
	
	mov eax, [esp + 8] ; 2 argument - length of array 

	movq mm0, [ecx]
	xor edx, edx
	sub eax, 8

loopy8:
	add edx, 8
	sub eax, 8
	movq mm1, [ecx + edx]
	movq mm2, mm0
	pcmpgtb mm2, mm1
	pand mm0, mm2
	pandn mm2, mm1
	pand mm1, mm2
	por mm0, mm1

	cmp eax, 8
	jge loopy8
	cmp eax, 4
	jge loopy4
	cmp eax, 2
	jge loopy2
	cmp eax, 1
	jge loopy1
	cmp eax, 0
	jge loopy0

loopy4:

	add edx, 8
	sub eax, 4
	movd mm1, [ecx + edx]
	punpckldq mm1, mm1
	movq mm2, mm0
	pcmpgtb mm2, mm1
	pand mm0, mm2
	pandn mm2, mm1
	pand mm1, mm2
	por mm0, mm1
	cmp eax, 2
	jge loopy2
	cmp eax, 1 
	jge loopy1

loopy2:
	int3
	add edx, 4
	sub eax, 2
	movd mm1, [ecx + edx]
	punpcklwd mm1, mm1
	movq mm2, mm0
	pcmpgtb mm2, mm1
	pand mm0, mm2
	pandn mm2, mm1
	pand mm1, mm2
	por mm0, mm1
	cmp eax, 2
	jge loopy2
	cmp eax, 1 
	jge loopy1
loopy1:
	mov ebx, 1
loopy0:
	mov ebx, 0

	movq mm1, mm0
	psrlq mm1, 32
	movq mm2, mm0
	pcmpgtb mm2, mm1
	pand mm0, mm2
	pandn mm2, mm1
	pand mm1, mm2
	por mm0, mm1

	movq mm1, mm0
	psrlq mm1, 16
	movq mm2, mm0
	pcmpgtb mm2, mm1
	pand mm0, mm2
	pandn mm2, mm1
	pand mm1, mm2
	por mm0, mm1

	movq mm1, mm0
	psrlq mm1, 8
	movq mm2, mm0
	pcmpgtb mm2, mm1
	pand mm0, mm2
	pandn mm2, mm1
	pand mm1, mm2
	por mm0, mm1

	movq [esp+8], mm0
	mov eax, [esp+8]
	emms 
	
	ret 


	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 