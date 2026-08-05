;=================================================================
; Procedure:	PrintUInt
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints a 32-bit unsigned-integer value to the standard output.
;
; Parameters:	
;	value: UINT -- A 32-bit unsigned-integer value	
;
; Returns:
;	Returns TRUE if print operation succeeded in EAX, otherwise
;	FALSE
;=================================================================

PrintUInt	PROC STDCALL, value: UINT
	LOCAL buffer[12]: BYTE

	push 12
	lea eax, buffer
	push eax
	mov eax, value
	push value
	call UIntToString

	push eax
	call PrintStringA
	
	ret
PrintUInt	ENDP