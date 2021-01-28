section .text
	;global _main
	extern _printf2
_main: 	
	mov ebx, "NAT"
	;BSWAP ebx
	push ebx
	push esp
	push my_text
	call _printf2 
	add esp, 12
	xor eax,eax
	RET	

	section .rdata ; секция даты только для чтения
my_text: db "Hello: %s",0 
my_second_text: db "Natasha", 0