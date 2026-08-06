.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc
include string.inc

.code
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
END