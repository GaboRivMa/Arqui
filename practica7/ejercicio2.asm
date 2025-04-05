.data
numero_msj: .asciiz "Ingresa el numero : "
promedio_msj: .asciiz "El promedio es: "
divisor: .float 5.0
cero: .float 0.0
salto: .asciiz "\n"

.text
.globl main

main:

	li $t0, 1 #t1 será el contador
	l.s $f2, cero  #iniciliza la suma
	l.s $f3, divisor #carga el divisor
	
obtener_suma:
	#imprime mensaje 
	li $v0, 4 #imprime string
    	la $a0, numero_msj #carga primer numero
    	syscall
    	
    	#imprime el contador
    	li $v0, 1 #imprime entero
    	move $a0, $t0 # prepara el contador para imprimir
    	syscall
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
	
	#aumenta el contador
	addi $t0, $t0, 1
	
	#guarda el float
	li $v0, 6 #lo guarda en f0
    	syscall
    	
    	#suma de flotantes
    	add.s $f2, $f2, $f0 #f2-f11 datos temporales
    	
    	#si aun faltan numeros, los suma
    	ble $t0, 5, obtener_suma
    	
    	#salta a la parte final
    	j sacar_promedio
    	
sacar_promedio:
	#saca el promedio
	div.s $f4, $f2, $f3  
    	
	#imprime mensaje 
	li $v0, 4 #imprime string
    	la $a0, promedio_msj #carga primer numero
    	syscall
    	
    	#imprime el resultado
    	li $v0, 2 #imprime float
    	mov.s $f12, $f4
    	syscall

exit:
    	li $v0, 10 #sale del programa
    	syscall
