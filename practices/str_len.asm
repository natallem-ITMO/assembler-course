section .text

	;global _main
	extern _str_len

_str_len: 
	mov ecx, [esp + 4] ; 1 argument - ref to array
	xor eax, eax; length of string
	mov [esp+4], ebx
	pxor xmm0, xmm0
	movdqu xmm1, [ecx]
	pcmpeqb xmm1, xmm0
	PMOVMSKB ebx, xmm1
	add ecx, 16
	test ebx, ebx
	jnz there
here:
	add eax, 16
	movdqu xmm1, [ecx]
	pcmpeqb xmm1, xmm0
	PMOVMSKB ebx, xmm1
	add ecx, 16
	test ebx, ebx
	jz here
there:
	bsf edx, ebx
	sub edx, 1
	add eax, edx
	mov ebx, [esp + 4]	
	ret 


	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 
zero: dq 0000
ddqZeroToFifteen:      db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
ddqTestValue:                 db 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
hello:                 db 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh, 0Fh
