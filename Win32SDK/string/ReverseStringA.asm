.386
.model flat, stdcall
option casemap:none

include windows.inc
include algorithm.inc

.code
;=================================================================
; Procedure:	ReverseStringA
;
; Calling Convention:	__stdcall
;
; Description:
;	Reverses the given string
;
; Parameters:	
;	lpBuffer:	LPSTR -- A null-terminated string
;	nStart:		DWORD -- Starting position from where to reverse
;	nEnd:		DWORD -- End position till where to reverse
;
; Returns:	None
;=================================================================

ReverseStringA	PROC STDCALL,
	lpBuffer:	LPSTR,
	nStart:		DWORD,
	nEnd:		DWORD

	push ebx
	push esi

	mov ebx, lpBuffer
	mov ecx, nStart
	mov esi, nEnd

@@:
	cmp ecx, esi
	jge	Epilogue

	push ecx
	lea eax, [ebx+ecx]
	push eax
	lea eax, [ebx+esi]
	push eax
	call SwapByte
	pop ecx

	inc ecx
	dec esi
	jmp @B

Epilogue:
	pop esi
	pop ebx
	ret

ReverseStringA	ENDP
END