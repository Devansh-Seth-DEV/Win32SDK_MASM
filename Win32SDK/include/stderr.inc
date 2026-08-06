;==============================================================================
; File        : stderr.inc
; Description : Standard Error Definitions Include File
;==============================================================================

; The 'C' at the start means "Severe Error". 
; The '000' in the middle for seperation.
; The last 4 digits are incremental error IDs.

STDERR_SUCCESS          EQU 000000000h    ; No error

STDERR_INVALID_DIGIT    EQU 0C0000001h    ; Error 1: Bad digit input

STDERR_BUFFER_OVERFLOW  EQU 0C0000002h    ; Error 2: Buffer ran out of space

STDERR_INVALID_HANDLE   EQU 0C0000003h    ; Error 3: Console handle failed

STDERR_PARSE_FAILED     EQU 0C0000004h    ; Error 4: String parsing failed

STDERR_UINT_PARSE_FAILED	EQU 0C0000005h		; Error 5: Unsigned interger string parse failed