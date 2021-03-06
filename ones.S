		;		ARM Programming Assignment #4: Count the ones in a binary number
		;
		;		Write a program that counts the number of ones in a binary number,
		;		stored in a word (4 bytes). Its loop should run no more times than there
		;		are ones in the number. Write the count in `numones`. For the example
		;		number given below, the loop should only run 8 times, counting 8 ones.
		;
		;		Hint:
		;		The first significant instruction in the loop is SUB r1, r1, 1, which
		;		decrements the number, assuming it's stored in register r1. Now,
		;		remember your logical operations.
		;
		;		Bonus:
		;		1. (20 extra points) For the shortest program (by instruction count),
		;		because this operation has to be FAST.
		;		2. (30 extra points) For extending the program to counting the ones
		;		in any word-aligned contiguous region of memory.
		
		;		Your code here
		
		ADR		R2, example
		LDR		R0, [R2]
		ADR		R2, mask
		LDR		R1, [R2]
		
		ADR		R9, numones
		
		MOV		R3, #0
		MOV		R5, #0
loop		AND		R4, R0, R1
		ADD		R3, R3, R4
		CMP		R4, #0
		ADDGT	R5, R5, #1
		CMP		R3, R0
		LSL		R1, R1, #1
		BLT		loop
		STR		R5, [R9]
		END
		
		
mask		DCD		0x00000001
example	DCD		0x0010070f
numones	FILL		4
