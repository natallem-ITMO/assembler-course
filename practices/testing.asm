section .text
	extern _printf2
_main: 
	mov ah, 'g'	
	mov esi, 3
	mov eax, 4
	lea ecx, ['0' + eax]
	inc esi
	mov byte [my+esi], 0
	push my
	push my_text
	call _printf2 ; comment 2
	add esp,8
	xor eax,eax
	RET

	section .data ; секция даты только для чтения
my_text: db "Hello: %s",0 
my: db "Natasha", 0