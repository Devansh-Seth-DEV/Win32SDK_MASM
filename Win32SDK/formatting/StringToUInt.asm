.386
.model flat, stdcall
option casemap:none

include windows.inc
include stderr.inc
include kernel32.inc
include console.inc

includelib kernel32.lib

.code
;=================================================================
; Procedure:	StringToUInt
;
; Calling Convention:	__stdcall
;
; Description:
;	Converts an unsigned 32-bit integer-string into an unsigned
;	32-bit integer value
;
; Parameters:
;	lpBuffer:		LPCSTR  -- A constant unsigned 32-bit 
;							integer-string
;	strLen:			SIZE_T	-- Length of the string
;
; Returns:
;	Returns the unsigned 32-bit integer value in EAX
;=================================================================

.code
StringToUInt	PROC STDCALL,
	lpBuffer:	LPCSTR,
	strLen:		SIZE_T

	push esi

	mov esi, lpBuffer
	mov ecx, strLen

	xor edx, edx
	xor eax, eax
	cld

NextDigit:
	lodsb
	and eax, 0FFh		; Clears everything in EAX except AL
	sub eax, '0'		; Convert ASCII char to numerical digit

	cmp eax, 9			; Comparing EAX with upper-bound
	ja Done				; If EAX < 0 then it'll become large unsigned int or else > 9 

	; Running Total = (Running Total * 10) + Digit
	imul edx, edx, 10
	add edx, eax

	loop NextDigit


Done:
	mov eax, edx
	
	pop esi
	ret

StringToUInt	ENDP
END