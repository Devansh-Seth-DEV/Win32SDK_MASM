.386
.model flat, stdcall
option casemap:none

include windows.inc
include stderr.inc
include kernel32.inc
include console.inc

includelib kernel32.lib

.code
;=================================================================
; Procedure:	StringToUInt
;
; Calling Convention:	__stdcall
;
; Description:
;	Converts an unsigned 32-bit integer-string into an unsigned
;	32-bit integer value
;
; Parameters:
;	lpBuffer:		LPCSTR  -- A constant unsigned 32-bit 
;							integer-string
;	strLen:			SIZE_T	-- Length of the string
;
; Returns:
;	Returns the unsigned 32-bit integer value in EAX
;=================================================================

.code
StringToUInt	PROC STDCALL,
	lpBuffer:	LPCSTR,
	strLen:		SIZE_T

	push ebx
	push esi
	push edi

	mov esi, lpBuffer
	mov ecx, strLen

	xor ebx, ebx	; EBX = Running total
	xor edi, edi	; EDI = Current digit value
	cld

FirstChar:
	lodsb
	cmp eax, '-'
	je OverflowError

	cmp eax, '+'
	je HandlePlus

	jmp ConvertToDigit

HandlePlus:
	loop NextDigit
	jmp EndCompute

NextDigit:
	lodsb

ConvertToDigit:
	and eax, 0FFh		; Clears everything in EAX except AL
	sub eax, '0'		; Convert ASCII char to numerical digit

	cmp eax, 9			; Comparing EAX with upper-bound
	ja EndCompute				; If EAX < 0 then it'll become large unsigned int or else > 9 

	mov edi, eax	; EDI = digit value

	mov eax, ebx	; EAX = running total
	mov edx, 10		; EDX = 10
	mul edx			; EDX:EAX = EAX * 10
	jc OverflowError

	add eax, edi		; Add new digit to product
	jc OverflowError

	mov ebx, eax

	loop NextDigit

EndCompute:
	mov eax, ebx
	jmp Done

OverflowError:
	or eax, -1

Done:
	pop edi
	pop esi
	pop ebx

	ret

StringToUInt	ENDP
END