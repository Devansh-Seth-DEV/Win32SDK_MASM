ifndef __FORMATTING_INC__
__FORMATTING_INC__ EQU 1

UIntToString	PROTO STDCALL, 
	value:				UINT,
	lpBuffer:			LPSTR,
	bufferCapacity:		SIZE_T

IntToString	PROTO STDCALL,
	value:				INT32,
	lpBuffer:			LPSTR,
	bufferCapacity:		SIZE_T
	
UIntToHex		PROTO STDCALL,
	value:				UINT,
	lpBuffer:			LPSTR,
	bufferCapacity:		SIZE_T

UIntToFixedHex	PROTO STDCALL,
	value:				UINT,
	lpBuffer:			LPSTR,
	bufferCapacity:		SIZE_T,
	nHexDigits:			SIZE_T


StringToUInt	PROTO STDCALL,
	lpBuffer:	LPSTR,
	strLen:		SIZE_T

endif