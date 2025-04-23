	.data
n:	.word 5
k:	.word 2
str_a: .asciiz "El coeficiente binomial de "
str_b: .asciiz " en "
str_c: .asciiz " es: "
	.text
	
main:
	#prepara los valores para trabajar
	lw 	$a0, n #guarda n
	lw 	$a1, k #guarda k
	
	#invoca a coef_bin para obtener el coeficniente binomail
	jal coef_bin
	move $s0, $v0  # Guardar resultado en $s0
	
	j imprimir_resultado

	
coef_bin:
	# PILA
	addi $sp $sp -12 # se crean 12 espacios 
	sw   $ra, 0($sp) #guarda la direccion para volver
    	sw   $a0, 4($sp) #guarda los valores 
    	sw   $a1, 8($sp) #guarda los valores
    	
	# CASOS BASE
	beqz $a1, caso_base # if k==0 then 1
	beq $a0, $a1, caso_base # if k==n then 1
	
	# CASO RECURSIVO 1
	subi $a0, $a0, 1 # n-1
	subi $a1, $a1, 1 # k-1
	jal coef_bin #calcula recursivamente (n-1, k-1)
	add $t0, $t0, $v0 # guarda resultado
	
	# RECUPERA LOS VALORES DE N , K
    	lw   $a0, 4($sp)   
    	lw   $a1, 8($sp)   
    	
    	# CASO RECURSIVO 2
 	subi $a0, $a0, 1 # n-1
	jal coef_bin #calcula recursivamente (n-1, k)
	add $t1, $t1, $v0 # guarda resultado

	# OBTIENE EL RESULTADO DE LA RECURSION
    	add $v0, $t0, $t1 # (n-1,k-1)+(n-1,k)
    	
    	# REINICIA LO ACUMULADO
    	move $t0, $zero
    	move $t1, $zero
    	
	# CONCLUSION
    	lw   $ra, 0($sp) # recupera ra 
	addi $sp, $sp, 12 # destruye la pila
    	jr $ra #regresa a donde se quedó en la ejecución
    	
    	
caso_base:
	addi $v0, $zero, 1 #retorna 1
	lw   $ra, 0($sp) # recupera ra
    addi $sp, $sp, 12 # destruye la pila
	jr $ra #regresa a donde se quedó en la ejecución
	
	
imprimir_resultado:
	#	"El coeficiente binomial de"
	li   $v0, 4         # Syscall para imprimir cadena
    	la   $a0, str_a  # Cargar dirección del mensaje
    	syscall
    	lw 	$a0, n #guarda n
	lw 	$a1, k #guarda k
    	#	"n"
	li   $v0, 1         # Syscall para imprimir entero
    	syscall
    	#	"en "
    	li   $v0, 4         # Syscall para imprimir cadena
    	la   $a0, str_b  # Cargar dirección del mensaje
    	syscall
    	#	"k"
    	move $a0, $a1 
	li   $v0, 1         # Syscall para imprimir entero
    	syscall
    	#	"es: "
    	li   $v0, 4         # Syscall para imprimir cadena
    	la   $a0, str_c  # Cargar dirección del mensaje
    	syscall
    	#	resultado
    	move $a0, $s0 
	li   $v0, 1         # Syscall para imprimir entero
    	syscall
    	
	
exit:
    	li $v0, 10 #sale del programa
    	syscall	








 
