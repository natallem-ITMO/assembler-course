section .text
	extern _MessageBoxA@16
	;global _main

_main:
	;https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messagebox
	push 4000h
	push my_title
	push my_str
	push 0
	call _MessageBoxA@16 ; �������� ���������� � �������� �������
	; add esp, 16 ; ������� ���� �� ���� �.�. stdcall
	ret ; ���� �� ������������, �� �������������� �� int3 ����� ���������(����� �� ���������)

section .data ; ������ ���� ������ ��� ������
	my_str: db "Here we go again...",0
	my_title: db "Oh, it's you.", 0