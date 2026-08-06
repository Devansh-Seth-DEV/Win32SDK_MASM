.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include console.inc

includelib kernel32.lib

.code
;=================================================================
; Procedure:	PrintCharA
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints a single ANSI character to the standard output.
;
; Parameters:	
;	character: DWORD -- Can be either stored in register/memory
;						or an immediate values like 'A' or 65.	
;
; Returns:
;	Returns the boolean status value inside the EAX register
;	to indicate whether the print operation is succeeded or
;	failed.
;	
;	- Success: EAX will contain a non-zero value (typically 1)
;	- Failed: EAX will contain zero (0)
;=================================================================

PrintCharA	PROC STDCALL, character: DWORD
	sub esp, 4	; __charsWritten

	lea ecx, [ebp-4]	; OFFSET __charsWritten
	lea eax, character

	push NULL
	push ecx
	push 1
	push eax
	push __console.stdOut.hStdOut
	call WriteConsoleA

	ret
PrintCharA	ENDP
END