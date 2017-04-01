;;;;;;;;;;;;;;;;;;;;;;;;;
; In-lab assesment	;
; Name: Thomas Hollis	;
; Student ID: 9720958	;
; Lab No. 1		;
; Exercise No. 4	;
;;;;;;;;;;;;;;;;;;;;;;;;;

processor 18F8722
config  OSC=HS, WDT=OFF, LVP=OFF
radix decimal

LATF    equ         0xF8E
TRISF   equ         0xF97
LATH    equ         0xF90
TRISH   equ         0xF99

;To make U: Turn On 7-seg LEDs - RF6 f, RF5 e, RF4 d, RF3 c, RF1 b

;Turn on transistors on RH1 and RH0
    MOVLW B'00000000'
    MOVWF LATH

;Display value U
    MOVLW B'10000101'   
    MOVWF LATF
    MOVLW B'00000000'   
    MOVWF TRISH         
    MOVLW B'00000000'   
    MOVWF TRISF         


L1      BRA         L1
end




