.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc

.code
PrintNewLine	PROC STDCALL
	INVOKE PrintCharA, CR
	INVOKE PrintCharA, LF
	ret
PrintNewLine	ENDP
END