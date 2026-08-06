.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc

.code
;=================================================================
; Procedure:	ReadStringA
;
; Calling Convention:	__stdcall
;
; Description:
;	Reads an ANSI word from the standard input.
;	Reads until any SPACE or Null-Terminator('\0') is found
;
; Parameters:	
;	- lpBuffer:		LPCSTR -- A pointer to a string to store the
;							  standard input
;   - nBufferSize:	DWORD  -- The size of the buffer
;
; Returns:
;	- lpBuffer will contain the word null-terminated string
;	- EAX will hold the total length of the word.
;=================================================================

ReadStringA	PROC STDCALL,
	lpBuffer:		LPSTR,
	nBufferSize:	DWORD

	push ebx

	call ConsoleLoadInputInBuffer

	cmp eax, 0
	jl Epilogue

	mov edx, lpBuffer
	xor ecx, ecx

; extract only one word from the line
@@:
	mov eax, __console.stdIn.position
	cmp eax, __console.stdIn.nLength
	je InsertNullTerminator

	cmp ecx, nBufferSize
	je InsertNullTerminator

	mov ebx, __console.stdIn.position
	cmp BYTE PTR [__console.stdIn.buffer+ebx], SYM_SPACE
	je FoundSpace

	mov al, BYTE PTR [__console.stdIn.buffer+ebx]
	mov BYTE PTR [edx+ecx], al
	
	inc ecx
	inc __console.stdIn.position
	jmp @B

FoundSpace:
	inc __console.stdIn.position

InsertNullTerminator:
	mov BYTE PTR [edx+ecx], 0
	mov eax, ecx

Epilogue:
	pop ebx
	ret

ReadStringA	ENDP
END