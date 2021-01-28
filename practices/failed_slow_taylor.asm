section .text
	extern _printf2
	;global _main
	;extern _taylor

_taylor: 
	;int3
	lea ecx, [esp+4]
	pushad
	fldz
	fld dword [ecx]
	;int3
	mov eax, [ecx + 4]

	;eax = arg2, st0 = cur_x, st1 = result
slag:
	sub eax, 1
	lea ebx, [eax * 2 +1]
	push dword ebx
	fild dword [esp]
	pop ebx
	fld1


	; gonna get x^(eax * 2 + 1)
	; st0=cur_x=1, st1=devider(=ebx), st2=original_x, st3=result, ebx=degree num
degree:
	fmul st0, st2
	sub ebx, 1
	jnz degree
	; st0 = x^(eax * 2 + 1), st1=devider(=ebx), st2=original_x, st3=result

	; получим x^n / n where n = (eax * 2 + 1)
	;fild dword [esp]
	;pop ebx
	;fdecstp 
	fdiv st0, st1
	;ffree st1
	;fild dword [esp]

	; домножим на -1 если текущая итерация нечетная
	test eax, 1
	JZ  even_iteration ; jump if even = lowest bit clear = zero
	FCHS
even_iteration:
	
	; прибавляем значениее к результату

	fadd st3, st0

	fcompp

	test eax, eax
	jnz slag
	;досчитали. st0 = origin_x, st1 = result

	fcomp st0

	popad; todo before call clean stack
	ret 

	section .rdata ; секция даты только для чтения
my_text: db "Factorial for number %f",0 