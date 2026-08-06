;==============================================================================
; File        : kernel32.inc
; Description : Prototypes for Kernel32.dll functions
; Author      : Devansh's Win32 SDK
;==============================================================================

;------------------------------------------
; Process Functions
;------------------------------------------

ifndef __KERNEL32_INC__
__KERNEL32_INC__ EQU 1

ExitProcess PROTO STDCALL, uExitCode: DWORD

;------------------------------------------
; Console Functions
;------------------------------------------

GetStdHandle	PROTO STDCALL, nStdHandle: DWORD

WriteConsoleA	PROTO STDCALL,
	hConsoleOutput:			HANDLE,
	lpBuffer:				LPCVOID,
	nNumberOfCharsToWrite:	DWORD,
	lpNumberOfCharsWritten:	LPDWORD,
	lpReserved:				LPVOID

ReadConsoleA	PROTO STDCALL,
	hConsoleInput:			HANDLE,
	lpBuffer:				LPCVOID,
	nNumberOfCharsToRead:	DWORD,
	lpNumberOfCharsRead:	LPDWORD,
	lpInputControl:			LPVOID


;------------------------------------------
; Heap Memory Management Functions
;------------------------------------------

GetProcessHeap	PROTO STDCALL

HeapAlloc	PROTO STDCALL,
	hHeap:		HANDLE,
	dwFlags:	DWORD,
	dwBytes:	SIZE_T

HeapFree	PROTO STDCALL,
	hHeap:		HANDLE,
	dwFlags:	DWORD,
	lpMem:		LPVOID

endif