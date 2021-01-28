section .text
	extern _printf2
	global _main

_main: 
	
	push float_num
	push my_text
	call _printf2
	add esp, 8

	;add esp, 8

	RET
	;сделать вывод из printf

	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 
float_num: dd 0.4