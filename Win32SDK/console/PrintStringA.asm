.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc

.code
;=================================================================
; Procedure:	PrintStringA
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints an ANSI string to the standard output.
;
; Parameters:	
;	lpBuffer: LPCSTR -- A long pointer to constant string
;
; Returns:
;	Returns TRUE if print operation succeeded in EAX, otherwise
;	FALSE
;=================================================================

PrintStringA	PROC STDCALL, lpBuffer: LPCSTR
	mov eax, lpBuffer
	push eax
	call ConsoleLoadOutputInBuffer

	call ConsoleFlushOutputBuffer

	ret
PrintStringA	ENDP
END