.data
cociente_msj: .asciiz "El cociente es : "
residuo_msj: .asciiz "El residuo es: "
salto: .asciiz "\n"

.text
.globl main

main:
	li $t0, 3 # divisor 
    	li $t1, 8 # dividendo
    	
    	 #Inicializar el cociente y el residuo
    	li $v0, 0   # $v0 = 0 inicializa el cociente
    	move $v1, $t1  # copia en $v1 el residuo que inicialmente es el dividiendo
    	
loop:
	bge $v1, $t0, restar #if(residuo >= divisor entonces vuelve a restar
	#si el residuo es menor que el dividendo entonces ya se encontro el cociente final y el residuo final
	j imprimir_resultado

restar:
	sub $v1, $v1, $t0 # v1(nuevo residuo) = residuo - divisor
	#aumenta el cociente en uno 
	addi $v0, $v0, 1 
	#vuelve a verificar si necesita seguir restando
	j loop
    
imprimir_resultado: 
	move $t2, $v0  # guarda el cociente para imprimirlo despues
	
	# Imprime el cociente
    	li $v0, 4 #Imprimir string
    	la $a0, cociente_msj # Carga mensaje 
    	syscall
    	li $v0, 1    
    	move $a0, $t2 #guarda el cociente  
    	syscall
    	li $v0, 4
    	la $a0, salto# Imprime salto de línea
    	syscall
    	
    	# Imprime el residuo
    	li $v0, 4 #Imprimir string
    	la $a0, residuo_msj # Carga mensaje 
    	syscall
    	li $v0, 1    
    	move $a0, $v1 #guarda el residuo  
    	syscall
    	li $v0, 4
    	la $a0, salto# Imprime salto de línea
    	syscall
    	
exit:
    	li $v0, 10 #sale del programa
    	syscall    

	