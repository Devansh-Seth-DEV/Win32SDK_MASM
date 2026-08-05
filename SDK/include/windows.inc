;==============================================================================
; File        : windows.inc
; Description : Definition of Windows Datatypes
; Author      : Devansh's Win32 SDK
;==============================================================================
ifndef __WINDOWS_INC__
__WINDOWS_INC__ EQU 1

;----------------------------------------
; Basic Constants
;----------------------------------------

NULL	EQU 0
TRUE	EQU 1
FALSE	EQU 0

__INPUT_BUFFER_DEFAULT_SIZE		EQU	256
__OUTPUT_BUFFER_DEFAULT_SIZE	EQU 1024

;----------------------------------------
; ASCII Symbol Constants
;----------------------------------------

CR		EQU 0Dh		; Carriage Return moves cursor back to very beginning of current line
LF		EQU 0Ah		; Line Feed moves cursor down one line, keeping in same horizontal column

SYM_SPACE	EQU	20h


;----------------------------------------
; Standard Handle Constants
;----------------------------------------

STD_INPUT_HANDLE	EQU	-10
STD_OUTPUT_HANDLE	EQU	-11
STD_ERROR_HANDLE	EQU	-12

;----------------------------------------
; Standard Heap Allocation Flags
; > These are the flags you pass directly 
; > the dwFlags parameter of HeapAlloc
;----------------------------------------

; Commands the kernel to fill the freshly allocated block of RAM with zeros 
; before passing the memory address back to the application
HEAP_ZERO_MEMORY	EQU 00000008h

; Disables mutual exclusion (thread safety) for the allocation. 
; This makes allocations faster, but it is dangerous if multiple threads attempt to access 
; the same heap at the same time. Do not use this on the default process heap.
HEAP_NO_SERIALIZE	EQU 00000001h

; Forces the system to raise a CPU exception (like an out-of-memory error) 
; instead of returning NULL if the allocation fails.
HEAP_GENERATE_EXCEPTIONS	EQU 00000004h

;----------------------------------------
; Advanced Heap Creation Flags
; > These flags are used specifically 
; > inside HeapCreate when defining a 
; > completely custom, private memory
;----------------------------------------

; Specifies that the heap can grow dynamically as needed. If this flag is omitted, 
; the heap has a fixed size and allocations will fail if they exceed the initial commit size.
HEAP_GROWABLE	EQU 00000002h

; Creates a heap where the allocated memory blocks have 
; Data Execution Prevention (DEP) bypassed. This allows you to store and execute 
; raw assembly machine code bytes dynamically from the heap block.
HEAP_CREATE_ENABLE_EXECUTE	EQU 00040000h

;----------------------------------------
; Reallocation Diagnostic Flags
; > These flags are used with HeapReAlloc 
; > or exposed internally by the OS 
; > during debugging
;----------------------------------------

; Used during resizing. It forces the heap manager to expand the memory block 
; exactly where it sits. If there is no free space right next to it, the function fails 
; rather than moving the data to a new memory address.
HEAP_REALLOC_IN_PLACE_ONLY	EQU 00000010h

; A diagnostic flag usually turned on automatically by a debugger. 
; It places a "guard signature" at the end of allocated memory buffers 
; to detect buffer overflows.
HEAP_TAIL_CHECKING_ENABLED	EQU 00000020h

; A diagnostic flag that monitors freed blocks of memory to quickly identify 
; "use-after-free" bugs.
HEAP_FREE_CHECKING_ENABLED	EQU 00000040h


;----------------------------------------
; Signed Integer Types
;----------------------------------------

CHAR	TYPEDEF	SBYTE	; ANSI character (signed 8-bit)
INT16	TYPEDEF SWORD	; signed 16-bit integer
INT32	TYPEDEF SDWORD	; signed 32-bit integer
LONG	TYPEDEF SDWORD	; signed 32-bit integer

;----------------------------------------
; Unsigned Integer Types
;----------------------------------------

UCHAR	TYPEDEF	BYTE	; unsigned 8-bit integer
USHORT	TYPEDEF WORD	; unsigned 16-bit integer
UINT	TYPEDEF DWORD	; unsigned 32-bit integer
ULONG	TYPEDEF DWORD	; unsigned 32-bit integer
SIZE_T	TYPEDEF DWORD	; unsigned 32-bit integer

;----------------------------------------
; Boolean Types
;----------------------------------------

BOOL	TYPEDEF INT32

;----------------------------------------
; Pointer Types
;----------------------------------------

PVOID		TYPEDEF PTR BYTE		; Pointer to arbitrary data
LPVOID		TYPEDEF PVOID			; Long pointer to arbitrary data (Win32 alias)

PCVOID		TYPEDEF PTR BYTE		; Pointer to constant arbitrary data
LPCVOID		TYPEDEF PCVOID			; Long pointer to constant arbitrary data (Win32 alias)

PBYTE		TYPEDEF PTR BYTE		; Pointer to byte
LPBYTE		TYPEDEF PBYTE			; Long pointer to byte

PWORD		TYPEDEF	PTR WORD		; Pointer to word
LPWORD		TYPEDEF PWORD			; Long pointer to word

PDWORD		TYPEDEF PTR DWORD		; Pointer to dword
LPDWORD		TYPEDEF PDWORD			; Long pointer to dword


PCHAR		TYPEDEF PTR CHAR		; Pointer to char
LPCHAR		TYPEDEF PCHAR			; Long pointer to char

PUCHAR		TYPEDEF PTR UCHAR		; Pointer to uchar
LPUCHAR		TYPEDEF PUCHAR			; Long pointer to uchar

PSHORT		TYPEDEF PTR INT16		; Pointer to short
LPSHORT		TYPEDEF PSHORT			; Long pointer to short

PUSHORT		TYPEDEF PTR USHORT		; Pointer to ushort
LPUSHORT	TYPEDEF PUSHORT			; Long pointer to ushort

PINT		TYPEDEF PTR INT32		; Pointer to int
LPINT		TYPEDEF PINT			; Long pointer to int

PUINT		TYPEDEF PTR UINT		; Pointer to uint
LPUINT		TYPEDEF PUINT			; Long pointer to uint

PLONG		TYPEDEF PTR LONG		; Pointer to long
LPLONG		TYPEDEF PLONG			; Long pointer to long

PULONG		TYPEDEF PTR ULONG		; Pointer to ulong
LPULONG		TYPEDEF PULONG			; Long pointer to ulong

PBOOL		TYPEDEF PTR BOOL		; Pointer to bool
LPBOOL		TYPEDEF PBOOL			; Long pointer to bool


;----------------------------------------
; ANSI String Types
;----------------------------------------

PSTR		TYPEDEF PTR BYTE	; Pointer to string
LPSTR		TYPEDEF PSTR		; Long pointer to string

PCSTR		TYPEDEF PTR BYTE	; Pointer to constant string
LPCSTR		TYPEDEF PCSTR		; Long pointer to constant string


;----------------------------------------
; Basic Handle Types
;----------------------------------------

HANDLE		TYPEDEF DWORD

HWND		TYPEDEF HANDLE
HINSTANCE	TYPEDEF HANDLE
HMODULE		TYPEDEF HANDLE
HICON		TYPEDEF HANDLE
HCURSOR		TYPEDEF HANDLE
HFILE		TYPEDEF HANDLE

;----------------------------------------
; MessageBox Control Types
;----------------------------------------

MB_OK					EQU	00000000h

MB_OKCANCEL				EQU 00000001h
MB_ABORTRETRYIGNORE		EQU 00000002h
MB_YESNOCANCEL			EQU 00000003h
MB_YESNO				EQU 00000004h
MB_RETRYCANCEL			EQU 00000005h

MB_ICONERROR			EQU 00000010h
MB_ICONQUESTION			EQU 00000020h
MB_ICONWARNING			EQU 00000030h
MB_ICONINFORMATION		EQU 00000040h

MB_SETFOREGROUND		EQU 00010000h
MB_TOPMOST				EQU	00040000h


;----------------------------------------
; MessageBox Return Values
;----------------------------------------

IDOK		EQU	1
IDCANCEL	EQU 2
IDABORT		EQU 3
IDRETRY		EQU 4
IDIGNORE	EQU 5
IDYES		EQU 6
IDNO		EQU 7

endif