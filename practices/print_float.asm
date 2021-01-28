section .text
	extern _printf2
	;global _main

_main: 
	;Помним, что в С функции с varargs не принимают флоат, поэтому выгружаем сразу 2 флота
	sub esp, 8
	fld dword [float_num]
	fstp qword [esp]
	push my_text
	call _printf2
	add esp, 12
	ret

section .rdata 
	my_text: db "Factorial for number %f",0 
	float_num: dd 0.0558