.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc
include formatting.inc

.code
;=================================================================
; Procedure:	PrintUIntHex
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints the hexadecimal value of an unsigned 32-bit integer 
;	value to the standard output.
;
; Parameters:	
;	value: UINT -- An unsigned 32-bit integer whole hex is to be
;				   printed
;
; Returns:
;	Returns TRUE if print operation succeeded in EAX, otherwise
;	FALSE
;
; Note:
;	The hexadecimal value printed is of variable length, and not
;	some fixed size value.
;	For example:
;		Value = 1, Hex = 0x1
;		Value = 16, Hex = 0x10
;=================================================================

PrintUIntHex	PROC STDCALL, value: UINT

	LOCAL buffer[12]:	BYTE

	push 12
	lea eax, buffer
	push eax
	mov eax, value
	push value
	call UIntToHex

	push eax
	call PrintStringA

	ret

PrintUIntHex	ENDP
END