;==============================================================================
; File        : user32.inc
; Description : Prototypes for user32.dll functions
; Author      : Devansh's Win32 SDK
;==============================================================================
ifndef __USER32_INC__
__USER32_INC__ EQU 1

MessageBoxA	PROTO STDCALL,
	hwnd:		HWND,
	lpText:		LPCSTR,
	lpCaption:	LPCSTR,
	uType:		UINT

wsprintfA PROTO C,
	lpBuffer:	LPSTR, 
	format:		LPCSTR,
	:VARARG

endif