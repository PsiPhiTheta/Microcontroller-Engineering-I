;;;;;;;;;;;;;;;;;;;;;;;;;
; In-lab assesment	;
; Name: Thomas Hollis	;
; Student ID: 9720958	;
; Lab No. 1		;
; Exercise No. 1	;
;;;;;;;;;;;;;;;;;;;;;;;;;

processor 18F8722
config  OSC=HS, WDT=OFF, LVP=OFF
radix decimal

    MOVLW 8     ;W=8
    MOVWF 11    ;x=8

    MOVLW 27    ;W=27
    MOVWF 12    ;y=27

    MOVLW 22    ;W=22
    MOVWF 13    ;z=22

l1  bra  l1

end


