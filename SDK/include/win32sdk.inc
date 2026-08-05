;==============================================================================
; File        : win32sdk.inc
; Description : Win32 SDK Master Include File
;==============================================================================

ifndef __WIN32SDK_INC__
__WIN32SDK_INC__ EQU 1

;--------------------------------------------------
; Windows Definitions
;--------------------------------------------------

include windows.inc
include kernel32.inc
include user32.inc

;--------------------------------------------------
; Common Definitions
;--------------------------------------------------

include limits.inc

;--------------------------------------------------
; SDK Modules
;--------------------------------------------------

include algorithm.inc
include formatting.inc
include string.inc
include console.inc

includelib kernel32.lib
includelib user32.lib

endif