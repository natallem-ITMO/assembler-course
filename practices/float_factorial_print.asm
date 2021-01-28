section .text
	extern _printf2
	;global _main
	extern _float_factorial_print

_float_factorial_print: 

	fld1 ;                                      ST0 = 1
	fild  dword [esp+4] ;                       ST0 = [esp+4] , ST1= 1
	fld1 ;                                      ST0 = 1  ST1 = [esp+4] , ST2= 1
	
fact:	
	fmul st0, st1
	fincstp ;                                   ST0 = counter , ST1 = 1 , ST7 = mul
	fsub st0, st1
	fdecstp
	sub eax, 1
	jnz fact

	;clean fpu stack exept result in st0
	fincstp
	fcompp
	fdecstp
	fdecstp
	fdecstp

	;result in st0, st1 - st7 are empty

	;print the result by calling printf2

	sub esp, 8
	fstp qword [esp]
	push my_text
	call _printf2
	add esp, 12
	ret 

	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 