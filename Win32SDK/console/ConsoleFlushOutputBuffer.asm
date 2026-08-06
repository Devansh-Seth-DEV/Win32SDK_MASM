.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include console.inc

includelib kernel32.lib

.code
;=================================================================
; Procedure:	ConsoleFlushOutputBuffer
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints the console output buffer to the standard output
;
; Parameters:	None	
;
; Returns:
;	Returns TRUE if print operation succeeded in EAX, otherwise
;	FALSE
;=================================================================

ConsoleFlushOutputBuffer	PROC STDCALL

	push ebp
	mov ebp, esp
	
	sub esp, 4			; charsWritten

	push NULL
	lea eax, [ebp-4]
	push eax
	push __console.stdOut.nLength
	push OFFSET __console.stdOut.buffer
	push __console.stdOut.hStdOut
	call WriteConsoleA
	
	test eax, eax
	jz WriteFailed

	mov __console.stdOut.nLength, 0
	mov eax, TRUE
	jmp Done

WriteFailed:
	xor eax, eax

Done:
	mov esp, ebp
	pop ebp
	ret

ConsoleFlushOutputBuffer	ENDP
END