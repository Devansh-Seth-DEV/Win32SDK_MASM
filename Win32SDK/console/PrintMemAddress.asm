.386
.model flat, stdcall
option casemap:none

include windows.inc
include console.inc
include formatting.inc

.code
;=================================================================
; Procedure:	PrintMemAddress
;
; Calling Convention:	__stdcall
;
; Description:
;	Prints the memory address stored inside a pointer to standard 
;	output
;
; Parameters:	
;	lpMem: LPCVOID -- A Long pointer to constant memory address
;
; Returns:
;	Returns TRUE if print operation succeeded in EAX, otherwise
;	FALSE
;
; Note:
;	The memory address printed is of fixed 8 hex digits value,
;	denoting 32-bit address size
;	For example:
;		Address = 1,  Hex = 0x00000001
;		Address = 16, Hex = 0x00000010
;=================================================================

PrintMemAddress	PROC STDCALL, lpMem:	LPCVOID
	
	LOCAL buffer[16]:	BYTE

	push 8
	push SIZEOF buffer
	lea eax, buffer
	push eax
	push lpMem
	call UIntToFixedHex

	push eax
	call PrintStringA

	ret

PrintMemAddress	ENDP
END