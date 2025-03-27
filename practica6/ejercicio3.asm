.data
primer_num: .asciiz "Ingresa el primer numero: "
segundo_num: .asciiz "Ingresa el segundo número: "
resultado_msj: .asciiz "Resultado: "
error_msj: .asciiz "Error, la suma es negativa"

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
    
    	#obtiene la resta 
    	sub $t2, $t0 $t1  #le resta t1 a t0 y lo guarda en t2
    
    	# Si $t2 >= 0, saltar a la etiqueta "positivo"
    	bgez $t2, positivo
    
    	#si no, mandar mensaje de error
    	li $v0, 4 #imprime string
    	la $a0,error_msj #imprime mensaje de error
    	syscall 
    	li $t2, 0 #limpia la memoria del resultado
    	j exit #terminar el programa
    
    
positivo:  
    	li $v0, 4 #imprime String 
    	la $a0, resultado_msj #Imprime el resultado msj
    	syscall
    	# Imprimir el resultado almacenado en $t2
    	li $v0, 1 #imprime int
    	move $a0, $t2 #guarda el número que estaba en t2
    	syscall
    
exit:
    	li $v0, 10 #sale del programa
    	syscall
