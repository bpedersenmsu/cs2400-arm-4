		;		ARM Programming Assignment #4: Encode in Hamming(15, 11)
		;
		;		Write a subroutine that encodes 11 bits of data into a 15-bit
		;		block, using 4 parity bits. Assume even parity, that is,
		;		the parity of the bits covered by a parity bit, including
		;		the parity bit, has to be an even number. Assume the bits are
		;		written in the following sequence: p1, p2, d1, p4, d2, d3, d4,
		;		p8, d5, d6, d7, d8, d9, d10, d11, p16, d12, d13, d14, d15.
		;		Call the subroutine `hencode`.
		;
		;		Write a subroutine that decodes a H(15, 11) block to extract
		;		the 11 data bits. Call it `hdecode`. It should:
		;		- calculate the correcting code
		;		- dentify the case: no error (noer), one-bit error (onee)
		;		- write the result in `case` using the encoding provided
		;		- if there is a one-bit error, write the number of the
		;		erroneous bit in `berr`
		;		- if there is a one-bit error, correct the data
		;		- write the result in `corr`
		;
		;		Now, write a main function which uses `hencode` and `decode`
		;		to encode `data` and then, after a simulated transmission,
		;		decode `recv`. Assume that `recv` contains what is received
		;		at the other end.
		
		;		Your code here
		ADR		R12, data
		ADR		R11, recv
		ADR		R10, mask
		
		LDR		R0, [R10]
		LDR		R1, [R12]
		LDR		R2, [R11]
		
		
		
encode	B		pOne
		
done		END
		
		
pOne		MOV		R10, #11 ; Positions to cycle through
		MOV		R12, R0 ; Set R12 = to mask
		LSL		R12, R12, #2 ; Move mask to position 3
		MOV		R7, #3 ; Starting Position for p1
cycleOne	AND		R11, R7, R10
		CMP		R11, #0
		BLGT		getVal
		LSL		R12, R12, #1 ; Move mask to next position
		SUBS		r10, r10, #1
		BNE		cycleOne
		ADR		R9, parity
		AND		R11, R3, R10
		CMP		R11, #0
		STR		R11, [R9]
		B		pTwo
		
pTwo		MOV		R10, #10 ; Positions to cycle through
		MOV		R12, R0 ; Set R12 = to mask
		LSL		R12, R12, #2 ; Move mask to position 5
		MOV		R7, #3 ; Starting Position for p1
		MOV		R4, #2
cycleTwo	AND		R11, R7, R4
		CMP		R11, #0
		BLGT		getVal
		LSL		R12, R12, #1 ; Move mask to next position
		ADD		R7, R7, #1
		SUBS		r10, r10, #1
		BNE		cycleTwo
		ADR		R9, parity
		AND		R11, R3, R10
		CMP		R11, #0
		STR		R11, [R9, #4]
		B		pThree
		
pThree	MOV		R10, #10 ; Positions to cycle through
		MOV		R12, R0 ; Set R12 = to mask
		LSL		R12, R12, #4 ; Move mask to position 5
		MOV		R7, #5 ; Starting Position for p1
		MOV		R4, #4
cycleThr	AND		R11, R7, R4
		CMP		R11, #0
		BLGT		getVal
		LSL		R12, R12, #1 ; Move mask to next position
		ADD		R7, R7, #1
		SUBS		r10, r10, #1
		BNE		cycleThr
		ADR		R9, parity
		AND		R11, R3, R10
		CMP		R11, #0
		STR		R11, [R9, #4]
		B		done
		
		
		
getVal	AND		R4, R1, R12
		ADDGT	R3, R3, #1
		MOV		PC, LR
		
mask		DCD		0x1
		
firstmask	DCD		0x4
scndmask	DCD		0x70
thrdmask	DCD		0x7F00
		
data		DCD		0b10100100101
recv		DCD		0b101111010100101
		
noer		DCD		0x00
onee		DCD		0x01
		
case		FILL		4
berr		FILL		4
corr		FILL		4
		
parity	fill		16
