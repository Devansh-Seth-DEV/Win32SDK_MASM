;=================================================================
; Procedure:	UIntToHex
;
; Calling Convention:	__stdcall
;
; Description:
;	Converts an unsigned 32-bit integer to a hexadecimal string
;	of variable length
;
;	For example:
;		Value = 1, Hex-String = "0x1"
;		Value = 16, Hex-String = "0x10"
;
; Parameters:	
;	value:			UINT   -- An unsigned 32-bit integer
;	lpBuffer:		LPSTR  -- A buffer to store the hex-string
;	bufferCapacity: SIZE_T -- Capacity of buffer, make sure that
;						   the buffer is large enough to store
;						   all the hex-digits of UINT_MAX
;
; Returns:
;	The EAX will holds the base-address from where the string
;	starts in lpBuffer
;=================================================================

UIntToHex	PROC STDCALL,
	value:			UINT,
	lpBuffer:		LPSTR,
	bufferCapacity:	SIZE_T

	push esi

	mov esi, lpBuffer
	mov ecx, bufferCapacity
	lea esi, [esi+ecx-1]

	mov BYTE PTR [esi], 0
	dec esi

	mov eax, value

NextNibble:
	mov edx, eax
	and edx, 0000000Fh

	cmp dl, 9
	jbe DecimalDigit

	add dl, 'A'-10
	jmp Store

DecimalDigit:
	add dl, '0'

Store:
	mov [esi], dl
	shr eax, 4
	dec esi

	test eax, eax
	jz PrependHexPrefix
	jmp NextNibble

PrependHexPrefix:
	mov BYTE PTR [esi], 'x'
	dec esi
	mov BYTE PTR [esi], '0'

	mov eax, esi

Done:
	pop esi
	ret

UIntToHex	ENDP