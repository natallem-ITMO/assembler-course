section .text
		extern _printf2
		;global _main

_main: 
	mov ebx, 6; comment , int3 command for debbuging
	mov edi, ebx
	xor edx,edx
	mov eax, 1
fact:
	mul ebx
	sub ebx, 1
	jnz fact
	push eax
	push edi
	push my_text
	call _printf2 ; comment 2
	add esp, 12
	xor eax,eax
	RET

	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %i = %i",0 