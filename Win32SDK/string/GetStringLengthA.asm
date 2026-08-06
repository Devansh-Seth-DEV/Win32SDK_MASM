.386
.model flat, stdcall
option casemap:none

include windows.inc

.code
;=================================================================
; Procedure:	GetStringLengthA
;
; Calling Convention:	__stdcall
;
; Description:
;	Computes the length of given a given null terminated string.
;
; Parameters:	
;	lpBuffer: LPCSTR -- An address of a null-terminated string
;
; Returns:
;	EAX will contain the length of given string
;=================================================================

GetStringLengthA	PROC STDCALL, lpBuffer: LPCSTR
	
	push esi

	mov esi, lpBuffer		; ESI = &lpBuffer[0]
	xor eax, eax

NextChar:
	lodsb

	cmp al, 0
	je Done
	jmp NextChar

Done:
	mov eax, lpBuffer
	sub esi, eax
	mov eax, esi

	pop esi
	ret
GetStringLengthA	ENDP
END