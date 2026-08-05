;==============================================================================
; File        : console.asm
; Description : Console Runtime Library
;==============================================================================

ConsoleInput	STRUCT
	hStdIn		HANDLE ?
	nLength		DWORD ?
	position	DWORD ?
	buffer		BYTE __INPUT_BUFFER_DEFAULT_SIZE DUP(?)
ConsoleInput	ENDS

ConsoleOutput	STRUCT
	hStdOut		HANDLE ?
	nLength		DWORD ?
	buffer		BYTE __OUTPUT_BUFFER_DEFAULT_SIZE DUP(?)
ConsoleOutput	ENDS

Console	STRUCT
	stdIn	ConsoleInput <>
	stdOut	ConsoleOutput <>
Console	ENDS

.data?
	__console	Console <>

.code

ConsoleInitialization 	PROC STDCALL
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov __console.stdIn.hStdIn, eax
	mov __console.stdIn.nLength, 0
	mov __console.stdIn.position, 0

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov __console.stdOut.hStdOut, eax
	mov __console.stdOut.nLength, 0

	ret
ConsoleInitialization 	ENDP


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

LoadBuffer:
	sub esp, 4							; nNumberOfCharsRead

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

	mov eax, DWORD PTR [ebp-4]		; EAX = nNumberOfCharsRead
	test eax, eax					; nNumberOfCharsRead == 0, read failed
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


;=================================================================
; Procedure:	ConsoleCheckOutputBufferOverflowPossible
;
; Calling Convention:	__stdcall
;
; Description:
;	Checks whether the output buffer overflow is possible or not
;	if we try to load N number of characters in output buffer
;
; Parameters:
;	nNumberOfCharsToWrite: DWORD -- Total chars for which overflow
;									to be checked.
;
; Returns:
;	Returns TRUE if overflow is possible in EAX, otherwise FALSE
;=================================================================

ConsoleCheckOutputBufferOverflowPossible	PROC STDCALL, 
	nNumberOfCharsToWrite:	DWORD
	
	xor eax, eax

	mov edx, __OUTPUT_BUFFER_DEFAULT_SIZE
	mov ecx, __console.stdOut.nLength
	sub edx, ecx							; EDX = freeSpaceLeft(stdOut::buffer)
	
	mov ecx, nNumberOfCharsToWrite			
	
	cmp ecx, edx							; nNumberOfCharsToWrite > EDX
	jg OverflowPossible						; Overflow is possible

	jmp Done

OverflowPossible:
	inc eax

Done:
	ret

ConsoleCheckOutputBufferOverflowPossible	ENDP


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


;=================================================================
; Procedure:	ConsoleLoadOutputInBuffer
;
; Calling Convention:	__stdcall
;
; Description:
;	Loads the output in the console output buffer(__console
;	.stdOut.buffer) and update its length(__console.stdIn.nLength)
;	, read cursor(__console.stdIn.position) to beginning.
;
;	The procedure loads the given output in chunks, if the given
;	chunk is greater that __OUTPUT_BUFFER_DEFAULT_SIZE, then
;	the procedure first flushes the current output buffer data
;	onto the display using ConsoleFlushOutputBuffer and then
;	loads the remaining chunk using same method
;
; Parameters:
;	- lpBuffer: LPCSTR -- A pointer to a constant string
;
; Returns:	None
;
; Note:
;	Since the procedure loads in chunks, there can be situations
;	where some chunks already gets flushed onto the display,
;	while the remaining are still present in output buffer waiting
;	for next flush call
;=================================================================

ConsoleLoadOutputInBuffer	PROC STDCALL,
	lpBuffer:				LPCSTR

	LOCAL remainingLen:	DWORD
	LOCAL chunkSize:	DWORD
	
	push esi
	push edi

	mov esi, lpBuffer			; ESI = source string to copy

	push esi
	call GetStringLengthA
	mov remainingLen, eax

	cld

WhileRemainingNZ:
	cmp remainingLen, 0
	je Done

	mov eax, __OUTPUT_BUFFER_DEFAULT_SIZE
	sub eax, __console.stdOut.nLength		; EAX = free space in buffer
	test eax, eax
	jz FlushCurrentOutput		; No free space

	mov ecx, remainingLen
	cmp ecx, eax
	jg FreeSpaceFits						; remaining > free

	mov chunkSize, ecx						; chunk = remaining
	jmp CopyChunks

FreeSpaceFits:
	mov chunkSize, eax						; chunk = free space

CopyChunks:
	mov ecx, chunkSize
	sub remainingLen, ecx

	mov edi, OFFSET __console.stdOut.buffer		; EDI = &stdOut::buffer
	add edi, __console.stdOut.nLength			; EDI += offset
	add __console.stdOut.nLength, ecx			; stdOut.nLength += ECX
	
	rep movsb
	jmp WhileRemainingNZ

FlushCurrentOutput:
	call ConsoleFlushOutputBuffer
	jmp WhileRemainingNZ

Done:
	
	pop edi
	pop esi
	ret

ConsoleLoadOutputInBuffer	ENDP


;--------------------------------------------------
; Console Runtime Functions
;--------------------------------------------------

include PrintCharA.asm
include PrintNewLine.asm
include PrintStringA.asm

include PrintUInt.asm
include PrintInt.asm
include PrintUIntHex.asm
include PrintMemAddress.asm


include ReadCharA.asm
include ReadLineA.asm
include ReadStringA.asm
include ReadUInt.asm

END