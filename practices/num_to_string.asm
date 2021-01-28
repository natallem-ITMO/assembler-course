section .text
	extern _printf2
	global _num_to_string

_num_to_string: 

	mov ebx, [esp + 4]
	;ebx - our num
	;mov ebx, 10
	mov eax, 1
	mov ecx, 10
	xor edx, edx	
mul10:
	mul ecx
	cmp eax, ebx
	jbe mul10
	; eax - max 10n graater then ebx
	xor edx, edx
	div ecx
	;eax is max 10n less or equal X(ebx)

	xor esi, esi ; обнулили счетчик смещения в массиве

divideAndWrite:
	xor edx, edx
	mov ecx, eax
	mov eax, ebx
	div ecx 
	;eac - то, что надо записать в ответ
	;edx - то, что надо дальше делить

	lea ebx, ['0' + eax]
	mov byte [my_number + esi], bl
	inc esi
	;записали цифру из eax

	mov ebx, edx
	
	; делим наш 10n делитель на 10
	xor edx, edx
	mov eax, ecx
	mov ecx, 10
	div ecx
	; in eax next 10n divider

	;надо проверить, что еах не равен нулю.
	test eax,eax
	jnz divideAndWrite

	;now y = 0, can show result, but need to write \0 char in the end
	mov byte [my_number + esi], 0

	;time to show result!!!

	push my_number	
	push my_text
	call _printf2 
	add esp, 8
	xor eax,eax
	RET	


	section .data ; секция даты только для чтения
my_text: db "Hello: %s",0 
my_number: db "000000000000000000000000000000000", 0