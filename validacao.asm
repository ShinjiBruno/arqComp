	addi $s6, $zero, 1 #contador primos
	addi $s7, $zero, 2 #ultimo primo encontradoo
	addi $s1, $zero, 1 # candidato

#loop:	beq $s6, 30, fim #30  primos
loop:	addi $s2, $zero, 1
	addi $s1, $s1, 2 #prox candidato (todo primo eh impar)
loopDiv:addi $s2, $s2, 1 #divisor
	beq $s2, $s1, contaPrimo
	addi $s3, $s1, 0 #aux para fazer as substracoes 
loopSub:blt $s3, $s2, fimSub
	sub $s3, $s3, $s2
	j loopSub

fimSub: beq $s3, 0, loop
	j loopDiv
contaPrimo: addi $s6, $s6, 1
	addi $s7, $s1, 0
	j loop

fim: