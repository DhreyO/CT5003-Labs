;============================================================
;   Turn Signal Controller (8051 Version)
;   Using C8051F120-style logic structure
;============================================================

; Capacitive Touch Turn Signal Controller

; C8051F120

$NOMOD51

$include (c8051f120.inc)

; -------- OUTPUTS on Port 2 (ACTIVE-LOW LEDs) --------
LEFT_4  EQU P2.0
LEFT_3  EQU P2.1
LEFT_2  EQU P2.2
LEFT_1  EQU P2.3
RIGHT_1 EQU P2.4
RIGHT_2 EQU P2.5
RIGHT_3 EQU P2.6
RIGHT_4 EQU P2.7

; -------- INPUTS on Port 1 (ACTIVE-LOW SWITCHES) --------
HAZ_SW   BIT P1.1        ; Blink all / hazard
RIGHT_SW BIT P1.2        ; Right indicator
LEFT_SW  BIT P1.4        ; Left indicator

; -------- Hazard blink state flag in RAM --------
HAZ_STATE EQU 20H        ; bit-addressable RAM byte
HAZ_FLAG  BIT 20H.0      ; 0 = LEDs off, 1 = LEDs on

ORG 00H
    LJMP Main

ORG 30H

; =========================================
Main:
    ACALL INIT

MAIN_LOOP:
    MOV P2, #0FFH          ; ensure all LEDs OFF at top of every loop (active-low)

    JB HAZ_SW,   HAZARD_MODE   ; switch active-low ? JB means "if 1" (not pressed)
    JB RIGHT_SW, RIGHT_MODE
    JB LEFT_SW,  LEFT_MODE

    ; Nothing touched — LEDs stay OFF
    SJMP MAIN_LOOP

; =========================================
; Hazard Mode: blink ALL LEDs together using a toggle flag
HAZARD_MODE:
    MOV SFRPAGE, #CONFIG_PAGE
    JB HAZ_FLAG, HAZ_ON     ; if flag set, turn them ON this cycle

HAZ_OFF:
    MOV P2, #0FFH           ; all LEDs OFF (active-low)
    SETB HAZ_FLAG           ; next call will turn ON
    ACALL WAIT
    SJMP MAIN_LOOP

HAZ_ON:
    MOV P2, #00H            ; all LEDs ON (active-low)
    CLR HAZ_FLAG            ; next call will turn OFF
    ACALL WAIT
    SJMP MAIN_LOOP

; =========================================
; Right Turn Sequence (active-low)
RIGHT_MODE:
    MOV SFRPAGE, #CONFIG_PAGE
    CLR HAZ_FLAG            ; reset hazard state
    MOV P2, #0FFH           ; start clean — all OFF

    CLR RIGHT_1             ; LED 1 ON, rest OFF
    ACALL WAIT
    CLR RIGHT_2
    ACALL WAIT
    CLR RIGHT_3
    ACALL WAIT
    CLR RIGHT_4
    ACALL WAIT

    MOV P2, #0FFH           ; all LEDs OFF before returning
    ACALL WAIT
    SJMP MAIN_LOOP

; =========================================
; Left Turn Sequence (active-low)
LEFT_MODE:
    MOV SFRPAGE, #CONFIG_PAGE
    CLR HAZ_FLAG            ; reset hazard state
    MOV P2, #0FFH           ; start clean — all OFF

    CLR LEFT_1
    ACALL WAIT
    CLR LEFT_2
    ACALL WAIT
    CLR LEFT_3
    ACALL WAIT
    CLR LEFT_4
    ACALL WAIT

    MOV P2, #0FFH           ; all LEDs OFF before returning
    ACALL WAIT
    SJMP MAIN_LOOP

; =========================================
; Delay Routine
WAIT:
    MOV R4, #05
L3: MOV R5, #0FFH
L1: MOV R6, #0FFH
L2: DJNZ R6, L2
    DJNZ R5, L1
    DJNZ R4, L3
    RET

; =========================================
; Initialization
INIT:
    ; Disable watchdog
    MOV WDTCN, #0DEH
    MOV WDTCN, #0ADH

    MOV SFRPAGE, #CONFIG_PAGE
    MOV XBR2, #40H          ; Enable crossbar

    ; Port 2 = LED outputs (push-pull)
    ORL P2MDOUT, #0FFH
    MOV P2, #0FFH           ; ALL LEDs OFF (active-low)

    ; Port 1 = switch inputs with pull-ups
    MOV P1MDOUT, #00H
    MOV P1, #0FFH

    CLR HAZ_FLAG            ; initialise hazard blink state to OFF
    RET

END

