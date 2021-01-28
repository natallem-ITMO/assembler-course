section .text
	extern _printf2
	global ?returnHaha@haha@@QAE?AU1@XZ

?returnHaha@haha@@QAE?AU1@XZ:
	mov eax, ebx
	mov edx, 3
	mov ebx, 4
	mov [ecx + ebx], edx
	add ebx, 4
	mov [ecx + ebx], edx
	add ebx, 4
	mov [esp+ebx], edx
	
	mov ebx, esp
	add ebx, 4
	mov eax, ebx 
	mov ebx, ecx
	;add esp, 8;- no need because cdecl
	RET 4

	section .data ; секция даты только для чтения
my_text: db "Hello: %i",0