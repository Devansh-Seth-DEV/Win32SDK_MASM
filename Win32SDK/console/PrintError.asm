.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include user32.inc
include console.inc

includelib kernel32.lib
includelib user32.lib

.const
	; 0x%08X:	The hex error code
	; %s:		The custom error message
	; %s:		The faulty error generating part
	errMsgFormat	BYTE "Error (0x%08X): %s '%s'", CR, LF, 0

.code
PrintError	PROC STDCALL,
	lpCulpritStr:	LPCSTR,
	lpErrMsg:		LPCSTR,
	errCode:		DWORD

	LOCAL charsWritten:	DWORD
	LOCAL msgBuffer[__ERROR_BUFFER_DEFAULT_SIZE]: BYTE

	push lpCulpritStr
	push lpErrMsg
	push errCode
	push OFFSET errMsgFormat
	lea eax, msgBuffer
	push eax
	call wsprintfA
	add esp, 20

	push NULL
	lea ecx, charsWritten
	push ecx
	push eax
	lea ecx, msgBuffer
	push ecx
	push __console.stdErr.hStdErr
	call WriteConsoleA

	mov eax, errCode
	ret

PrintError	ENDP
END