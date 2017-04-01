;;;;;;;;;;;;;;;;;;;;;;;;;
; In-lab assesment	;
; Name: Thomas Hollis	;
; Student ID: 9563426	;
; Lab No. [?]		;
; Exercise No. [?]	;
;;;;;;;;;;;;;;;;;;;;;;;;;

;Precompiler directives
    processor 18F8722				;Tell the assembler what processor to compile
    config OSC=HS,WDT=OFF,LVP=OFF		;High speed Oscillator, Watch Dog timer is off, Low Voltage programming (LVP) is off.
    radix decimal		  		;The default number base we are using.
    org  0x00					;Build in absolute mode
    ;SET IN IDE: clock@10Mz so processor needs 4 crystal clock oscillations to perform 1 instruction (so instruction frequency is 2.5MHz) and some take twice as long (GOTO) therefore 0.0004ms per instruction 
    ;if PIC doesn't compile check the filename is legal in MPLABX and disconnect & reconnect PICkit3
    
;Port functions(use IO Circuit Diagram for specifics)
	;Port A: Analogue inputs from the rotary potentiometer (RA0), the LM335Z temperature sensor (RA1) and the Light Dependent Resistor (RA2). Digital output to control the transistor Q3 (RA4).
	;Port B: Push-button PB1 digital input (RB0).
	;Port C: Toggle switch digital inputs (RC2, RC3, RC4 and RC5). Least significant.
	;Port F: Digital outputs for controlling the 8 discrete LEDs and the 7-segment displays (RF0 ? RF7).
	;Port H: Digital outputs to control the 7-segment multiplexing transistors Q1 and Q2 (RH0 and RH1). Toggle switch digital inputs (RH4, RH5, RH6 and RH7). Most significant.
	;Port J: Push-button PB1 digital input (RJ5). Digital output for controlling the sounder (RJ6).    

;Addresses
	;		LATx(write out)		TRISx(1n|0ut)		PORTx(read in)
	;Port A 	0xF89 			0xF92 			0xF80
	;Port B 	0xF8A 			0xF93 			0xF81
	;Port C 	0xF8B 			0xF94 			0xF82
	;Port D 	0xF8C 			0xF95 			0xF83
	;Port E 	0xF8D 			0xF96 			0xF84
	;Port F 	0xF8E 			0xF97 			0xF85
	;Port G 	0xF8F 			0xF98 			0xF86
	;Port H 	0xF90 			0xF99 			0xF87
	;Port J 	0xF91 			0xF9A 			0xF88
	
;Commands
	;MOVLW x (move litteral x to working register WR)
	;MOVWF f (move working register to memory address f)
	;MOVF f,W (move contents of memory address f into WR)
	;ADDLW k (add constant k to working register)
	;ADDWF f (add contents of memory address f to WR and store in f)
	;ADDWF f,W (add contents of memory address f to WR and store in WR)
	;BRA L1 (branch unconditionally to label L1)
	;BZ (branch if the ALU zero flag is true)
	;BNZ (branch if the ALU zero flag is false)
	;BN (branch if the ALU nagative flag is true)
	;BNN (branch if the ALU negative flag is false)
	;RRNCF (rotate right no carry)
	;IORWF f (Inclusive OR WR with f)
	;XORWF f (Exclusive OR WR with f)
	;ANDWF f (AND WR with f - use to make if statements with inputs and bit rotation)
	;MULWF f (multiply WR with f)
	;DECF f (decrement memory address f)
	;INCF f (increment memory address f)
	;CLRF f (clear memory address f)
	;SETF f (set memory address f)
	;CALL function_name (calls function)
	;RETURN (returns from function back to main)
	;use datasheet for more instructions

;SFR definitions
	;PB1
TRISB	equ 	0xF93  	;enable tristate B (output - 0, input - 1)
LATB 	equ 	0xF8A  	;enable latch B (write output high - 1 or low - 0) 
PORTB 	equ 	0xF81 	;enable port B (read input using MOVF port, W)
	
	;7-seg&LEDS
LATF 	equ 	0xF8E 	;enable port F (LEDs and U1)
TRISF	equ 	0xF97 	;enable port F (LEDs and U1)
PORTF	equ 	0xF85 	;enable port F (LEDs and U1)
LATH 	equ 	0xF90 	;enable port H (transistor Q1)
TRISH	equ 	0xF99 	;enable port H (transistor Q1)
PORTH	equ 	0xF87 	;enable port H (transistor Q1)
TRISA	equ 	0xF92	;LED enabling (set to 0 for output)
LATA 	equ 	0xF89	;To set the actual output value (pin high or low = LED on or off)

	;change from analogue input (default) to GPIO
ADCON1 	equ 	0xFC1 	;follow this by the commands "MOVLW 0x0F" & "MOVWF ADCON1" to activate

	;variables
innerloop	equ 	14 		;sets the address for innerloopnum
outerloop	equ 	15 		;sets the address for outerloopnum	
	
;Main
Start

    MOVLW 100
    MOVWF outerloop ;count=2

outerdelay ;wait 20ms = 50 000 (50 000*0.4us = 20ms)
    ;Wait 200us = 500 cycles (500*0.4us = 200us) 
    CALL dly200us     ;count = 502
    DECF outerloop
    BNZ outerdelay	;count=505
    ;end of outer loop
    
    ;count~50500
    
    ;Loop back to start
    BRA Start ; Got back to the start - loop forever

;Subroutines
dly200us			
    NOP
    NOP
    NOP
    NOP
    NOP				
    MOVLW 49			;Setting the value of innerloopnum, this is the number of times
    MOVWF innerloop		;the loop will repeat
				;count=10   
innerdelay			
    NOP				
    NOP				
    NOP				
    NOP				
    NOP				
    NOP
    NOP
    DECF innerloop		;decrements innerloopnum by 1
    BNZ innerdelay		;count = 10 + 9||10(49)

    RETURN			

END



