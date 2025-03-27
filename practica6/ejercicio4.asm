.data
primer_num: .asciiz "Ingresa el primer numero: "
segundo_num: .asciiz "Ingresa el segundo número: "
suma_msj: .asciiz "Suma: "
resta_msj: .asciiz "Resta: "
multi_msj: .asciiz "Multiplicacion: "
div_msj: .asciiz "Division: "	
error_msj: .asciiz "No se puede dividir entre 0 "
salto: .asciiz "\n"


.text
.globl main

main:
    	#obtiene el primer número
    	li $v0, 4 #imprime string
    	la $a0, primer_num #carga primer numero
    	syscall
    	li $v0, 5 #entrada de tipo int mientras el programa se ejecuta, el número se guarda en v0
    	syscall
    	move $t0, $v0   # Guardar el número en t0 
    
    	#obtiene el segundo número
   	li $v0, 4 #imprime string
    	la $a0, segundo_num #carga segundo numero
    	syscall
    	li $v0, 5 #entrada de tipo int mientras el programa se ejecuta, el número se guarda en v0
    	syscall
    	move $t1, $v0   # Guardar el número en t1
    
    	#suma 
    	add $t2, $t0 $t1  #t2=t0+t1
    	li $v0, 4 #imprime String 
    	la $a0, suma_msj #Imprime el resultado msj
    	syscall
    	li $v0, 1 #imprime int
    	move $a0, $t2 #guarda el número que estaba en t2
    	syscall
    	li $v0, 4
    	la $a0, salto #imprime salto
    	syscall
    
   	#resta 
    	sub $t2, $t0 $t1  #le t2=t0-t1
    	li $v0, 4 #imprime String 
    	la $a0, resta_msj #Imprime el resultado msj
    	syscall
    	# Imprimir el resultado almacenado en $t2
    	li $v0, 1 #imprime int
    	move $a0, $t2 #guarda el número que estaba en t2
    	syscall
    	li $v0, 4
    	la $a0, salto #imprime salto
    	syscall
    
    	#multiplicacion
    	mul $t2, $t0, $t1  # $t2 = $t0 * $t1
    	li $v0, 4 #imprime String 
    	la $a0,multi_msj #Imprime el resultado msj
    	syscall
    	# Imprimir el resultado almacenado en $t2
    	li $v0, 1 #imprime int
    	move $a0, $t2 #guarda el número que estaba en t2
    	syscall
    	li $v0, 4
    	la $a0, salto #imprime salto
    	syscall
    
    	#division
    	beqz $t1, error #t1=0 -> error
    	div $t2, $t0, $t1  # $t2 = $t0 / $t1
    	li $v0, 4 #imprime String 
    	la $a0,div_msj #Imprime el resultado msj
    	syscall
    	# Imprimir el resultado almacenado en $t2
    	li $v0, 1 #imprime int
    	move $a0, $t2 #guarda el número que estaba en t2
    	syscall
    	j exit

error:	
    	li $v0, 4
    	la $a0, error_msj
    	syscall
    	
exit:
    	li $v0, 10 #sale del programa
    	syscall
