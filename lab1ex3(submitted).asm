;;;;;;;;;;;;;;;;;;;;;;;;;
; In-lab assesment	;
; Name: Thomas Hollis	;
; Student ID: 9720958	;
; Lab No. 1		;
; Exercise No. 3	;
;;;;;;;;;;;;;;;;;;;;;;;;;

processor 18F8722
config  OSC=HS, WDT=OFF, LVP=OFF
radix decimal

LATF    equ         0xF8E ;0 is low, 1 is high - high latch applies 5V, low latch applies 0V
TRISF   equ         0xF97 ;1 is input, 0 is out, each latch and tristate have different numbers for LED, might need flags from 3rd exercise, ex4=4marks, partial solutions
LATA    equ         0xF89
TRISA   equ         0xF92


;sets values
    MOVLW 8     ;W=8
    MOVWF 11    ;x=8

    MOVLW 27    ;W=27
    MOVWF 12    ;y=27

    MOVLW 22    ;W=22
    MOVWF 13    ;z=22

;defines x
    MOVF        13, W   ;W=z
    SUBWF       12, W   ;W=y-z
    ADDLW       2       ;W=y-z+2
    ADDWF       11      ;x=y-z+2+x

;display x in binary on LEDs
    MOVLW       0           ;W=0
    MOVWF       TRISF       ;tristateF=0
    MOVWF       TRISA       ;tristateA=0
    MOVLW       B'00010000' ;W=00010000
    MOVWF       LATA        ;latchA=00010000
    MOVF        11, W       ;W=y-z+2+x
    MOVWF       LATF        ;latchF=W

L1      BRA         L1
end





