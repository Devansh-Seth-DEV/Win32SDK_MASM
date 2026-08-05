;==============================================================================
; File        : limits.inc
; Description : Limits of Primitive Datatype
;==============================================================================

;----------------------------------------
; Integer Limit Constants
;----------------------------------------

ifndef __LIMITS_INC__
__LIMITS_INC__ EQU 1

INT_MIN		EQU	80000000h
INT_MAX		EQU 7FFFFFFFh

UINT_MIN	EQU 00000000h
UINT_MAX	EQU 0FFFFFFFFh

endif