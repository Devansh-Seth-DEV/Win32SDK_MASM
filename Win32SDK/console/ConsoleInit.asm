.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include console.inc

includelib kernel32.lib

.code
ConsoleInit	PROC STDCALL
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov __console.stdIn.hStdIn, eax
	mov __console.stdIn.nLength, 0
	mov __console.stdIn.position, 0

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov __console.stdOut.hStdOut, eax
	mov __console.stdOut.nLength, 0

	INVOKE GetStdHandle, STD_ERROR_HANDLE
	mov __console.stdErr.hStdErr, eax

	ret
ConsoleInit	ENDP
END