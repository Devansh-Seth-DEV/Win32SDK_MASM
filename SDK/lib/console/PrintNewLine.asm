PrintNewLine	PROC STDCALL
	INVOKE PrintCharA, CR
	INVOKE PrintCharA, LF
	ret
PrintNewLine	ENDP