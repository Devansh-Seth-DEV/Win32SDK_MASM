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
	LOCAL buffer[16]: BYTE

	push SIZEOF buffer
	lea eax, buffer
	push eax
	call ReadStringA

	push eax
	lea eax, buffer
	push eax
	call StringToUInt

	ret
ReadUInt	ENDP