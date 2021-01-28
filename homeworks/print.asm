section .text
	global _print

_print:
	push				ebx
	push				esi
	push				edi
	push				ebp

; I) READ FLAGS
	mov					edx,					[esp+4*4 + 8]		; adress of start of string format
read_flags:
	xor					eax,					eax
	mov					al,						[edx]
	inc					edx
	test				eax,					eax
	jz					read_hex_string

	cmp					al,						'-'
	je					minus_flag_input

	cmp					al,						'+'
	je					plus_flag_input

	cmp					al,						'0'
	je					zero_flag_input
	
	cmp					al,						' '
	je					blank_flag_input

	sub					eax,					'0'
	mov					ebx,					eax
	mov					ecx,					10

read_num:

	xor					eax,					eax
	mov					al,						[edx]
	inc					edx
	test				eax,					eax
	jz					write_width_flag

	sub					eax,					'0'
	imul				ebx,					ecx
	add					ebx,					eax
	jmp					read_num

minus_flag_input:
	mov		byte		[minus_flag],			1
	jmp					read_flags
	
plus_flag_input:
	mov		byte		[plus_flag],			1
	jmp					read_flags
	
zero_flag_input:
	mov		byte		[zero_flag],			1
	jmp					read_flags
	
blank_flag_input:
	mov		byte		[blank_flag],			1
	jmp					read_flags


write_width_flag:
	mov		dword		[width_flag],			ebx
	

; II) READ HEX STRING

; II.1) try to read first string symbol '-' to invert.

read_hex_string:

	mov					edx,					[esp+4*4 + 12]		; start of string adress
	xor					ebx,					ebx
	mov					bl,						[edx]
	cmp					ebx,					'-'
	jne					prepare_for_str_len	
	mov		byte		[leading_minus],		1
	inc					edx


; II.2) count length of hex string
; edx - adress of start of hex string
; eax - hex string length
prepare_for_str_len:
	
	xor					eax,					eax					;current len of hex string
											
	xor					ecx,					ecx
	mov					cl,						[edx + eax]
	test				ecx,					ecx
	jz					end_print

str_len:
	inc					eax
	mov					cl,						[edx + eax]
	test				ecx,					ecx
	jnz					str_len
	
; II.3) check if length is even
; if even, read one symbol
	mov					ecx,					1
	and					ecx,					eax
	shr					eax,					1
	test				ecx,					ecx		
	jz 					even_length

	inc					eax
	xor					ebx,					ebx
	mov					bl,						[edx]

	call				get_number
	mov					esi,					16
	sub					esi,					eax
	mov		byte		[binary_num + esi],		bl
	dec					eax
	inc					edx

; II.4) read even number of symbols in hex string

; eax - length of hex string / 2
; edx - adress of first unread symbol of hex string
even_length:				
	test				eax,					eax
	jz					invert_if_leading_minus
	xor					ebx,					ebx
	mov					bl,						[edx]
	inc					edx
	call				get_number
	mov					ecx,					ebx
	shl					ecx,					4
	mov					bl,						[edx]
	inc					edx
	call				get_number
	xor					ebx,					ecx
	mov					esi,					16
	sub					esi,					eax
	dec					eax
	mov		byte		[binary_num + esi],		bl
	jmp					even_length
	
;					II.5) check if input hex string started with '-' and invert if so, also invert if negative
invert_if_leading_minus:
	cmp		byte		[leading_minus],		0
	je					check_and_invert_if_negative	
	mov		byte		[leading_minus],		0
	call				invert 

check_and_invert_if_negative:		;check if current number is negative
						;			if true -> 1) leading_minus = 1
						;					   2) invert input number
	xor					eax,				eax
	mov		byte		al,					[binary_num]
	cmp					eax,				0x80
	jl					translation
	mov		byte		[leading_minus],		1
	call				invert

; III) TRANSLATE INTO DECIMAL NUMBER

translation:
	mov					esi,					0
	mov					ebx,					10

; esi - shift in 'decimal_num' for current decimal number
; ebx = 10
translation_loop:
	xor					ecx,					ecx
	xor					edi,					edi
	xor					edx,					edx

translation_div_iteration_loop:
	mov					eax,					[binary_num+4*edi]
	bswap				eax
	div					ebx
	or					ecx,		 			eax
	bswap				eax
	mov					[binary_num+4*edi],		eax
	inc					edi
	cmp					edi,					4
	jne					translation_div_iteration_loop
	
	mov		byte		[decimal_num + esi],	dl
	inc					esi	
	test				ecx,					ecx
	jnz					translation_loop


; IV) PRINT RESULT
; esi - length of number without sign

	mov						eax,				[esp+4*4 + 4]	
	mov						ecx,				1

	;check if  (to not to print '-' sign)
	cmp						esi,				1
	jne						not_zero
	cmp		byte			[decimal_num],		0
	jne						not_zero
	mov		byte			[leading_minus],	0
	jmp						check_plus

not_zero:	
	cmp						cl,					[leading_minus]
	jne						check_plus
	inc						esi
	mov		byte			[leading_minus],	'-'
	jmp						compare_width
	
check_plus:
	cmp						cl,					[plus_flag]
	jne						check_blank
	inc						esi
	mov		byte			[leading_minus],	'+'
	jmp						compare_width
	
check_blank:
	cmp						cl,					[blank_flag]
	jne						compare_width
	inc						esi
	mov		byte			[leading_minus],	' '
	
compare_width:
	mov						ebx,				[width_flag]
	cmp						esi,				ebx
	jge						print_whole_number

	sub						ebx,				esi
	;ebx - number of symbols to fill the void

	cmp						cl,					[minus_flag]
	je						left_justify
	
	cmp						cl,					[zero_flag]
	je						leading_zeros

	mov						edx,				' '
	call					print_n_symbols
	call					print_sign
	call					print_number
	jmp						end_print	

leading_zeros:
	call					print_sign
	mov						edx,				'0'
	call					print_n_symbols
	call					print_number
	jmp						end_print		

left_justify
	call					print_sign
	call					print_number
	mov						edx,				' '
	call					print_n_symbols
	jmp						end_print		

print_whole_number:			
	call					print_sign
	call					print_number
	

; eax - adress of byte to write terminate '\0' symbol
end_print:
	xor					ebx,					ebx
	mov		byte		[eax],					bl

	call clean_all_data

	pop					ebp
	pop					edi
	pop					esi
	pop					ebx
	ret 


;invert binary_num and add 1
invert:	
	
	mov					eax,					[binary_num + 4 * 3]		
	mov					ebx,					[binary_num + 4 * 2]		
	mov					ecx,					[binary_num + 4 * 1]		
	mov					edx,					[binary_num]
	bswap eax
	bswap ebx
	bswap ecx
	bswap edx
	not eax
	not ebx
	not ecx
	not edx
	add					eax,					1
	adc					ebx,					0
	adc					ecx,					0
	adc					edx,					0
	bswap eax
	bswap ebx
	bswap ecx
	bswap edx
	mov					[binary_num + 4 * 3],	eax		
	mov					[binary_num + 4 * 2],	ebx
	mov					[binary_num + 4 * 1],	ecx		
	mov					[binary_num],			edx
	ret
		
; in ebx char to transform
get_number:			
	cmp					ebx,					'9'
	jbe					isNum
	cmp					ebx,					'F'
	jbe					isUpperAlpha
	cmp					ebx,					'f'
	jbe					isLowerAlpha

isNum:
	sub					ebx,					'0'
	ret

isUpperAlpha:
	sub					ebx,					'A'
	add					ebx,					10
	ret

isLowerAlpha:
	sub					ebx,					'a'
	add					ebx,					10
	ret		


; eax - start byte to write
print_sign:
	xor					edx,					edx
	mov		byte		dl,						[leading_minus]
	test				edx,					edx
	jz					return_from_print_sign
	dec					esi
	mov		byte		[eax],					dl
	inc					eax
return_from_print_sign:
	ret


; eax - start byte to write
; esi - length of output number (in digits)
print_number:
	dec					esi
	mov					edx,					[decimal_num + esi]
	add					edx,					'0'
	mov		byte		[eax],					dl
	inc					eax
	test				esi,					esi
	jnz					print_number
	ret

; eax - start byte to write
; ebx - how many times print char
; edx - char to print
print_n_symbols:
	dec					ebx
	mov		byte		[eax],					dl
	inc					eax
	test				ebx,					ebx
	jnz					print_n_symbols
	ret

; ebx should be 0
clean_all_data:
	xor					eax,					eax
loop1:
	mov		dword		[binary_num + 4*eax],	ebx
	inc					eax
	cmp					eax,					4
	jne					loop1
	
	xor					eax,					eax
loop2:
	mov		dword		[decimal_num + 4*eax],	ebx
	inc					eax
	cmp					eax,					10
	jne					loop2
	

	mov		byte		[leading_minus],		bl
	mov		byte		[zero_flag],			bl
	mov		byte		[minus_flag],			bl
	mov		byte		[plus_flag],			bl
	mov		byte		[blank_flag],			bl
	mov		dword		[width_flag],			ebx
	ret

section .data 

binary_num:				dq		0,0				; input string binary representation
decimal_num:			dt		0,0,0,0			

leading_minus:			db		0
zero_flag:				db		0
minus_flag:				db		0
plus_flag:				db		0
blank_flag:				db		0
width_flag:				dd		0
