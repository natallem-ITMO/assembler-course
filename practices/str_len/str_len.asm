section .text
	extern _printf2
	;global _main
	extern _str_len

_str_len: 
	mov ecx, [esp + 4] ; 1 argument - ref to array
	xor eax, eax ; length of string
	int3
	movdqu xmm0, [ecx]

	movdqu xmm1, [ecx+16]
	pcmpeqb xmm0, xmm1  
	psrlq xmm1, 1
   ; TZCNT xmm0
   ; int3
	movdqu xmm0, [ddqTestValue]
	pxor xmm1, xmm1                             ; zero XMM1
	pcmpeqb xmm0, xmm1                          ; set to -1 for all matching

	pandn xmm0, xmm3

	;psrlq xmm0, 64
	PCMPEQB xmm0, xmm1
	;bsf eax, xmm0
	ret 


	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 
zero: dq 0 
ddqZeroToFifteen:      db 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
ddqTestValue:                 db 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
