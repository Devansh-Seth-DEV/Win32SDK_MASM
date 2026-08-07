.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc

.code
;=================================================================
; Procedure:	ReadUInt
;
; Calling Convention:	__stdcall
;
; Description:
;	Reads an unsigned 32-bit integer value from standard input
;
; Parameters:	None
;
; Returns:
;	Returns the unsigned 32-bit integer value in EAX
;=================================================================

ReadUInt	PROC STDCALL
	push ebx
	push esi
	push edi
	
	call ConsoleLoadInputInBuffer

	cmp eax, 0
	jl ReadFailed

	cld
	mov esi, OFFSET __console.stdIn.buffer

	xor edi, edi
	xor ebx, ebx	; EBX = running total
	xor ecx, ecx	; ECX = digit value

FirstNonNumbers:
	lodsb
	mov cl, al

	cmp cl, SYM_SPACE
	je FirstNonNumbers
	cmp cl, SYM_TAB
	je FirstNonNumbers

	cmp cl, '-'
	je SkipDigits

	cmp cl, '+'
	je NextChar

	jmp ConvertToDigit

NextChar:
	lodsb
	mov cl, al

ConvertToDigit:
	and ecx, 0FFh	; ECX = digit char
	sub ecx, '0'	; ECX = digit value

	cmp ecx, 9
	ja NotDigit

	mov eax, ebx	; EAX = running total
	mov edx, 10
	mul edx			; EDX:EAX = EAX * 10
	jc OverflowError

	add eax, ecx
	jc OverflowError

	mov ebx, eax
	jmp NextChar

ReadFailed:
	xor eax, eax
	jmp Done

SkipDigits:
	lodsb
	and eax, 0FFh
	sub eax, '0'

	cmp eax, 9
	ja NotDigit

OverflowError:
	mov edi, TRUE
	jmp SkipDigits

NotDigit:
	test edi, edi
	jnz RaiseOverflow
	mov eax, ebx
	jmp Done

RaiseOverflow:
	or eax, -1

Done:
	dec esi
	mov ebx, OFFSET __console.stdIn.buffer
	sub esi, ebx
	mov __console.stdIn.position, esi

	pop edi
	pop esi
	pop ebx

	ret
ReadUInt	ENDP
END