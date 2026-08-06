.386
.model flat, stdcall
option casemap:none

include windows.inc

.code
;=================================================================
; Procedure:	UIntToFixedHex
;
; Calling Convention:	__stdcall
;
; Description:
;	Converts an unsigned 32-bit integer to a hexadecimal string
;	of fixed length
;
;	For example:
;		Value = 1,	nHexDigits = 8, Hex-String = "0x00000001"
;		Value = 16, nHexDigits = 4, Hex-String = "0x0010"
;
; Parameters:	
;	value:			UINT   -- An unsigned 32-bit integer
;	lpBuffer:		LPSTR  -- A buffer to store the hex-string
;	bufferCapacity: SIZE_T -- Capacity of buffer, make sure that
;						   the buffer is large enough to store
;						   all the nHexDigits plus 3 ('0x' prefix
;						   and a null-terminator)
;	nHexDigits:		SIZE_T -- Number of fixed hex digits to be
;						   generated in the string
;
; Returns:
;	The EAX will holds the base-address from where the string
;	starts in lpBuffer
;=================================================================

UIntToFixedHex	PROC STDCALL,
	value:			UINT,
	lpBuffer:		LPSTR,
	bufferCapacity:	SIZE_T,
	nHexDigits:		SIZE_T

	push esi

	mov esi, lpBuffer
	mov ecx, bufferCapacity
	lea esi, [esi+ecx-1]

	mov BYTE PTR [esi], 0
	dec esi

	mov eax, value
	mov ecx, nHexDigits

@@:
	mov edx, eax
	and edx, 0Fh

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

	loop @B

PrependHexPrefix:
	mov BYTE PTR [esi], 'x'
	dec esi
	mov BYTE PTR [esi], '0'

Done:
	mov eax, esi

	pop esi
	ret

UIntToFixedHex	ENDP
END