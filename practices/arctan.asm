section .text
	extern _printf2
	;global _main
	extern _taylor

_taylor: 
	fldz
	fld dword [esp+4] ; 1 argument
	fld st0
	fmul st1, st0
	fld1
	fld1
	fadd st1, st0
	mov eax, [esp + 8] ; 2 argument

	;eax = arg2, st0 = cur_d (x^n / d - slag), st1 = 2, st2 = cur_x^n, st3= x^2 , st4 = result
slag:
	fld st2
	fdiv st0, st1
	test eax, 1
	JZ  even_iteration ; jump if even = lowest bit clear = zero
	FCHS
even_iteration:
	fadd st5, st0
	fcomp st0
	;прибавили к результату текущее слагаемое, вернулись в состояние исходное
	fadd st0, st1
	; two options (change top of stack or swap, time the same)
	; 1)
	;fincstp
	;fincstp
	;fmul st0, st1
	;fdecstp
	;fdecstp

	; 2)
	fxch st2
	fmul st0, st3
	fxch st2
	sub eax, 1
	test eax, eax
	jnz slag
	
	;досчитали.
	fcompp 
	fcompp 
	;result in st0

	ret 

	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 