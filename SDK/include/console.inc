;==============================================================================
; File        : console.inc
; Description : Prototypes for custom console runtime library
;==============================================================================
ifndef __CONSOLE_INC__
__CONSOLE_INC__ EQU 1

ConsoleInitialization	PROTO STDCALL

ConsoleCheckOutputBufferOverflowPossible	PROTO STDCALL,
	nNumberOfCharsToWrite:	DWORD

ConsoleFlushOutputBuffer	PROTO STDCALL

ConsoleFlushOutputBufferIfNeeded	PROTO STDCALL,
	nNumberOfCharsToWrite:	DWORD

PrintCharA		PROTO STDCALL, character: DWORD

PrintNewLine	PROTO STDCALL

PrintStringA	PROTO STDCALL, lpBuffer: LPCSTR


PrintUInt	PROTO STDCALL, value: UINT

PrintInt	PROTO STDCALL, value: INT32

PrintUIntHex	PROTO STDCALL, value: UINT

PrintMemAddress	PROTO STDCALL, lpMem:	LPCVOID


ReadCharA	PROTO STDCALL

ReadLineA	PROTO STDCALL,
	lpBuffer:		LPSTR,
	nBufferSize:	DWORD

ReadStringA	PROTO STDCALL, 
	lpBuffer:		LPSTR, 
	nBufferSize:	DWORD


ReadUInt	PROTO STDCALL

endif