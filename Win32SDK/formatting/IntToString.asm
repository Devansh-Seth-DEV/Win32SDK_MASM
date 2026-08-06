.386
.model flat, stdcall
option casemap:none

include windows.inc
include formatting.inc

.code
;=================================================================
; Procedure:	IntToString
;
; Calling Convention:	__stdcall
;
; Description:
;	Converts a signed 32-bit integer to a string
;
; Parameters:	
;	value:			INT32  -- A signed 32-bit integer
;	lpBuffer:		LPSTR  -- A buffer to store the string
;	bufferCapacity: SIZE_T -- Capacity of buffer, make sure that
;						   the buffer has capacity large enough
;						   to store all the digits of INT_MAX
;
; Returns:
;	The EAX will holds the base-address from where the string
;	starts in lpBuffer
;=================================================================

IntToString	PROC STDCALL, 
	value:				INT32,
	lpBuffer:			LPSTR,
	bufferCapacity:		SIZE_T

	LOCAL isNegative:	BOOL

	mov isNegative, FALSE

	mov eax, value
	cmp eax, 0
	jge Convert

	neg eax
	mov isNegative, TRUE

Convert:
	mov ecx, bufferCapacity
	push ecx
	mov ecx, lpBuffer
	push ecx
	push eax
	call UIntToString

	cmp isNegative, FALSE
	je Done

	dec eax		; EAX = address of first empty slot before digit
	mov BYTE PTR [eax], '-'

Done:
	ret

IntToString	ENDP
END