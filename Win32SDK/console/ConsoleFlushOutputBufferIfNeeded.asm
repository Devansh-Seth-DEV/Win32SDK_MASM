.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc

.code
;=================================================================
; Procedure:	ConsoleFlushOutputBufferIfNeeded
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints the console output buffer to the standard output only
;	if, the output buffer is completely filled and new output is
;	waiting to be loaded, so the procedure flushes the current
;	output to stdOut, if the output buffer is not completely
;	filled, then no output is printed on stdOut
;
; Parameters:	None	
;
; Returns:
;	Returns TRUE in EAX if output is flushed to stdOut, otherwise
;	FALSE
;=================================================================

ConsoleFlushOutputBufferIfNeeded	PROC STDCALL,
	nNumberOfCharsToWrite:	DWORD

	mov eax, nNumberOfCharsToWrite
	push eax
	call ConsoleCheckOutputBufferOverflowPossible

	test eax, eax
	jz Done

	call ConsoleFlushOutputBuffer

Done: 
	ret

ConsoleFlushOutputBufferIfNeeded ENDP
END