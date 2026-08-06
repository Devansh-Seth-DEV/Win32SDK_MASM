.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc
include formatting.inc

.code
;=================================================================
; Procedure:	PrintInt
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints a 32-bit signed-integer value to the standard output.
;
; Parameters:	
;	value: INT32 -- A 32-bit signed-integer value	
;
; Returns:
;	Returns TRUE if print operation succeeded in EAX, otherwise
;	FALSE
;=================================================================

PrintInt	PROC STDCALL, value: INT32
	LOCAL buffer[12]: BYTE

	push 12
	lea eax, buffer
	push eax
	mov eax, value
	push value
	call IntToString

	push eax
	call PrintStringA
	
	ret
PrintInt	ENDP
END