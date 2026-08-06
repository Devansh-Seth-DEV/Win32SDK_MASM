.386
.model flat, stdcall
option casemap:none

include windows.inc

.code
;=================================================================
; Procedure:	SwapByte
;
; Calling Convention:	__stdcall
;
; Description:
;	Swap the byte values of two memory addresses
;
; Parameters:
;	lpMem1: LPBYTE -- Pointer to first memory of byte data
;	lpMem2: LPBYTE -- Pointer to second memory of byte data
;
; Returns:	None
;=================================================================

SwapByte	PROC STDCALL,
	lpMem1:	LPBYTE,
	lpMem2:	LPBYTE

	mov eax, lpMem1
	mov edx, lpMem2

	mov cl, BYTE PTR [eax]
	mov ch, BYTE PTR [edx]

	mov BYTE PTR [eax], ch
	mov BYTE PTR [edx], cl

	ret

SwapByte	ENDP
END