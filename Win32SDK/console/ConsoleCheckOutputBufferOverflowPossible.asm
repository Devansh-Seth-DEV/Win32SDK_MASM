.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc

.code
;=================================================================
; Procedure:	ConsoleCheckOutputBufferOverflowPossible
;
; Calling Convention:	__stdcall
;
; Description:
;	Checks whether the output buffer overflow is possible or not
;	if we try to load N number of characters in output buffer
;
; Parameters:
;	nNumberOfCharsToWrite: DWORD -- Total chars for which overflow
;									to be checked.
;
; Returns:
;	Returns TRUE if overflow is possible in EAX, otherwise FALSE
;=================================================================

ConsoleCheckOutputBufferOverflowPossible	PROC STDCALL, 
	nNumberOfCharsToWrite:	DWORD
	
	xor eax, eax

	mov edx, __OUTPUT_BUFFER_DEFAULT_SIZE
	mov ecx, __console.stdOut.nLength
	sub edx, ecx							; EDX = freeSpaceLeft(stdOut::buffer)
	
	mov ecx, nNumberOfCharsToWrite			
	
	cmp ecx, edx							; nNumberOfCharsToWrite > EDX
	jg OverflowPossible						; Overflow is possible

	jmp Done

OverflowPossible:
	inc eax

Done:
	ret

ConsoleCheckOutputBufferOverflowPossible	ENDP
END