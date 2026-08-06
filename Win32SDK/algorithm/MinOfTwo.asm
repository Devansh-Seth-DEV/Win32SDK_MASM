.386
.model flat, stdcall
option casemap:none

include windows.inc

.code
MinOfTwo	PROC STDCALL, num1: INT32, num2: INT32
	mov eax, num1
	cmp eax, num2
	jle Done
	mov eax, num2

Done:
	ret
MinOfTwo	ENDP
END