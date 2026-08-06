.386
.model flat, stdcall
option casemap:none

include windows.inc

.code
;=================================================================
; Procedure:	UIntToString
;
; Calling Convention:	__stdcall
;
; Description:
;	Converts an unsigned 32-bit integer to a string
;
; Parameters:	
;	value:			UINT   -- An unsigned 32-bit integer
;	lpBuffer:		LPSTR  -- A buffer to store the string
;	bufferCapacity: SIZE_T -- Capacity of buffer, make sure that
;						   the buffer has capacity large enough
;						   to store all the digits of UINT_MAX
;
; Returns:
;	The EAX will holds the base-address from where the string
;	starts in lpBuffer
;=================================================================

UIntToString	PROC STDCALL, 
	value:				UINT,
	lpBuffer:			LPSTR,
	bufferCapacity:		SIZE_T

	push esi

	mov esi, lpBuffer
	mov ecx, bufferCapacity
	lea esi, [esi+ecx-1]
	mov BYTE PTR [esi], 0
	dec esi

	mov eax, value
	test eax, eax
	jz ValueIsZero

	mov ecx, 10		; divident = 10 to get LS-Digit

@@:	
	test eax, eax
	jz Done

	; EAX = Quotient, EDX = Remainder, ECX = Divident
	xor edx, edx
	div	ecx

	add dl, '0'
	mov BYTE PTR [esi], dl
	dec esi
	jmp @B


ValueIsZero:
	mov BYTE PTR [esi], '0'
	dec esi

Done:
	lea eax, [esi+1]

	pop esi
	ret

UIntToString	ENDP
END