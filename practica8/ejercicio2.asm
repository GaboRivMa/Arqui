	.data
n:	.word 2
k:	.word 1
mensaje: .asciiz "El coeficiente binomial es : "
	.text
	
main:
	#prepara los valores para trabajar
	lw 	$a0, n #guarda n
	lw 	$a1, k #guarda 
	#invoca a coef_bin para obtener el coeficniente binomail
	jal coef_bin
	move $s0, $v0  # Guardar resultado en $s0
	
	li   $v0, 4         # Syscall para imprimir cadena
    	la   $a0, mensaje   # Cargar dirección del mensaje
    	syscall
    	move $a0, $s0 
	li   $v0, 1         # Syscall para imprimir entero
    	syscall
	j exit	

	
coef_bin:
	# PILA
	addi $sp $sp -12 # se crean 12 espacios 
	sw   $ra, 0($sp) #guarda la direccion para volver
    	sw   $a0, 4($sp) #guarda los valores 
    	sw   $a1, 8($sp) #guarda los valores
    	
    	# Guarda temporalmente los valores n y k
    	move $t2, $a0  # n
	move $t3, $a1  # k
	
	# CASOS BASE
	beqz $a1, caso_base # if k==0 then 1
	beq $a0, $a1, caso_base # if k==n then 1
	
	# CASO RECURSIVO
	subi $a0, $t2, 1 # n-1
	subi $a1, $t3, 1 # k-1
	jal coef_bin #calcula recursivamente (n-1, k-1)
	move $t0, $v0 #guarda el resultado en t0
 
	subi $a0, $t2, 1 # n-1
	move $a1, $t3
	jal coef_bin #calcula recursivamente (n-1, k)
	move $t1, $v0 #guarda el resultado en t1

    	add $v0, $t0, $t1 # (n-1,k-1)+(n-1,k)
    	
    	# CONCLUSION
    	lw   $ra, 0($sp) # recupera ra 
    	lw   $a0, 4($sp) # recupera los valores iniciales
    	lw   $a1, 8($sp) # recupera los valores iniciales
	addi $sp, $sp, 12 # destruye la pila
    	jr   $ra #return

caso_base:
	addi $v0, $zero, 1 #retorna 1
	lw   $a0, 4($sp) # recupera los valores iniciales
    	lw   $a1, 8($sp) # recupera los valores iniciales
	jr $ra #regresa a donde se quedó en la ejecución
	
exit:
    	li $v0, 10 #sale del programa
    	syscall	








 
