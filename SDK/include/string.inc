ifndef __STRING_INC__
__STRING_INC__ EQU 1

GetStringLengthA	PROTO STDCALL, lpBuffer: LPCSTR

ReverseStringA	PROTO STDCALL,
	lpBuffer:	LPSTR,
	nStart:		DWORD,
	nEnd:		DWORD

endif