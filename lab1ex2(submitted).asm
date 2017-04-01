;;;;;;;;;;;;;;;;;;;;;;;;;
; In-lab assesment	;
; Name: Thomas Hollis	;
; Student ID: 9720958	;
; Lab No. 1		;
; Exercise No. 2	;
;;;;;;;;;;;;;;;;;;;;;;;;;

processor 18F8722
config  OSC=HS, WDT=OFF, LVP=OFF
radix decimal
org  0x00	

    MOVLW 8     ;W=8
    MOVWF 11    ;x=8

    MOVLW 27    ;W=27
    MOVWF 12    ;y=27

    MOVLW 22    ;W=22
    MOVWF 13    ;z=22

    MOVF 13,W   ;W=z
    ADDWF 11,W  ;W=z+x
    ADDLW -7    ;W=z+x-7, note: ALU flag = 1
    ADDWF 12    ;y=z+x+y-7

l1  bra  l1
end
    


