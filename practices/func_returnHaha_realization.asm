section .text
	extern _printf2
	global ?returnHaha@@YA?AUhaha@@XZ
	;global _main

?returnHaha@@YA?AUhaha@@XZ
	mov ecx, ebx
	mov edx, 3
	mov ebx, 4
	mov [esp+ebx], edx
	add ebx, 4
	mov [esp + ebx], edx
	add ebx, 4
	mov [esp+ebx], edx
	
	mov ebx, esp
	add ebx, 4
	mov eax, ebx 
	mov ebx, ecx
	;add esp, 8; - no need because cdecl
	RET 

	section .data ; секция даты только для чтения
my_text: db "Hello: %i",0