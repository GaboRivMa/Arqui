	.data
a:	.word 4
b:	.word 5
	.text
.globl main

#El código reliza la operacion b^a

main:	# Inicializa los valores de a y b y manda a llamar a mist_1
	#preaumbulo main
	lw 	$a0, a #guarda a en a0
	lw 	$a1, b #guarda b en a1
	addi 	$sp, $sp, -8 # se crean 12 espacios 
	sw   	$a0, 0($sp) #guarda los valores3
	sw   	$ra, 4($sp) #guarda la direccion para volver
    	
	#invocacion de mist_1
	jal mist_1
	
	#retorno de mist_1
	move $t0, $v0 #s1 es para guardados tras llamada y v0 para retornos de subrutinas
	
	#conclusion main
	lw $a0, 0($sp) #guarda la direccion para volver
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	move $a0, $t0   # mover el resultado a $a0
	
	#Para imprimir resultado
	#li   $v0, 1         # Syscall para imprimir entero
    	#syscall
    	
    	
	#fin del programa
	li $v0, 10     # código de salida del sistema
	syscall        # terminar el programa correctamente

#mist_1 recibe como argumentos $a0 y $a1
mist_1: # Llama a mist_0 y va acumulando su resultado, repite este proceso a0 veces
	#preambulo mist
	addi $sp, $sp, -12 # se crean 12 espacios 
	sw   $ra, 8($sp) #guarda la direccion para volver
    	sw   $s0, 4($sp) #guarda los valores 
    	sw   $a1, 0($sp) #guarda los valores
    	
	move	$s0, $a0 #s0=a0
	move	$t0, $a1 #t0=a1
	li	$t1, 1 #t1=1
	
loop_1: beqz $s0, end_1 #if s0==0 then end_1,	
	#invocacion de mist_0
	move	$a0, $t0 #pasa el argumento $a0
	move	$a1, $t1 #pasa el argumento $a1
	jal mist_0
	
	#retorno de mist_0
	move	$t1, $v0 #pasa el argumento $a0
	
	addi	$s0, $s0, -1 #pasa el argumento $a1
	j loop_1

end_1: 
	#conclusion mist_1
	move	$v0, $t1 #se retorna el resultado en v0
	lw   	$a1, 0($sp) # recupera los valores iniciales
	lw   	$s0, 4($sp) # recupera los valores iniciales
	lw   	$ra, 8($sp) # recupera ra 
	addi 	$sp, $sp, 12 # destruye la pila
	jr $ra
	
#mist_o recibe como argumentos $a0 y $a1
mist_0: # multiplica a0*a1 y devuelve el resultado
	#preambulo mist_0
	addi 	$sp, $sp, -4 # se crean 12 espacios 
	sw   	$ra, 0($sp) #guarda la direccion para volver

	mult	$a0, $a1
	mflo	$v0 #se retorna el resultado en v0
	
	#conclusion mist_0
	lw   $ra, 0($sp) # recupera ra 
	addi $sp, $sp, 4
	#regresa a mist_1
	jr $ra
	
