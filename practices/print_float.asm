section .text
	extern _printf2
	;global _main

_main: 
	;������, ��� � � ������� � varargs �� ��������� �����, ������� ��������� ����� 2 �����
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