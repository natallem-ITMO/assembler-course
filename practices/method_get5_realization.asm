section .text
	extern _printf2
	global ?return5@haha@@QAEHXZ


?return5@haha@@QAEHXZ:
	mov ecx, [esp+4];this link
	mov ebx, 23
	push ecx
	push my_text
	call _printf2 ; comment 2
	mov eax, ebx;
	add esp, 8
	RET	

	section .data ; секция даты только для чтения
my_text: db "In get5 method Haha a = %i",0