;==============================================================================
; File        : console.inc
; Description : Prototypes for custom console runtime library
;==============================================================================
ifndef __CONSOLE_PRIVATE_INC__
__CONSOLE_PRIVATE_INC__ EQU 1

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

ConsoleError	STRUCT
	hStdErr		HANDLE ?
ConsoleError	ENDS

Console	STRUCT
	stdIn	ConsoleInput <>
	stdOut	ConsoleOutput <>
	stdErr	ConsoleError <>
Console	ENDS

ConsoleInit	PROTO STDCALL

ConsoleCheckOutputBufferOverflowPossible	PROTO STDCALL,
	nNumberOfCharsToWrite:	DWORD

ConsoleFlushOutputBuffer	PROTO STDCALL

ConsoleFlushOutputBufferIfNeeded	PROTO STDCALL,
	nNumberOfCharsToWrite:	DWORD

ConsoleLoadInputInBuffer	PROTO STDCALL

ConsoleLoadOutputInBuffer	PROTO STDCALL,
	lpBuffer:				LPCSTR

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