.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include console.inc

includelib kernel32.lib

.code
;=================================================================
; Procedure:	ConsoleLoadInputInBuffer
;
; Calling Convention:	__stdcall
;
; Description:
;	Loads the input in the console input buffer(__console.stdIn.
;	buffer) and update its length(__console.stdIn.nLength), read
;	cursor(__console.stdIn.position) to beginning.
;
; Parameters:	None	
;
; Returns:
;	- Success: EAX will contain length of input buffer
;	- Failed: EAX will contain -1
;=================================================================

ConsoleLoadInputInBuffer	PROC STDCALL
	push ebp
	mov ebp, esp

	; Checks if input buffer is available or not!
	mov eax, __console.stdIn.position
	cmp eax, __console.stdIn.nLength
	jb Epilogue

	sub esp, 4							; nNumberOfCharsRead

LoadBuffer:
	push NULL
	lea eax, [ebp-4]
	push eax
	push __INPUT_BUFFER_DEFAULT_SIZE-1
	push OFFSET __console.stdIn.buffer
	push __console.stdIn.hStdIn
	call ReadConsoleA

	; Check if ReadConsoleA fails or succeed!
	test eax, eax
	jz ReadFailed

	; TODO: Re-read until character is pressed except CR,LF
	mov eax, DWORD PTR [ebp-4]		; EAX = nNumberOfCharsRead
	test eax, eax						; nNumberOfCharsRead <= 2, read failed
	jz ReadFailed

	dec eax										; EAX -= 1 (treating EAX as 0-indexed of buffer)
	mov ecx, OFFSET __console.stdIn.buffer		; ECX = buffer (Address of 1st char)

	cmp BYTE PTR [ecx+eax], LF			; buffer[EAX] != LF skip to check previous byte
	jne @F
	dec eax								; for \0 will to added at EAX-1 since previous byte is CR
	jmp AppendNullTerminator

@@: 
	cmp BYTE PTR [ecx+eax], CR			; buffer[EAX] == CR skip to append
	je AppendNullTerminator
	
	inc eax		; else \0 to be addded at EAX+1 because there is no CR LF in string

AppendNullTerminator:
	; EAX now equals final string length
	mov BYTE PTR [ecx+eax], 0		; buffer[EAX] = '\0'
	jmp SetInputAttributes

ReadFailed:
	or eax, -1
	mov __console.stdIn.nLength, 0
	mov __console.stdIn.position, 0

	jmp Epilogue

SetInputAttributes:
	mov __console.stdIn.nLength, eax
	mov __console.stdIn.position, 0

Epilogue:
	mov esp, ebp
	pop ebp
	ret
	
ConsoleLoadInputInBuffer	ENDP
END