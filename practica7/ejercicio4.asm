.data
divisor_msj: .asciiz "Ingresa el divisor:  "
dividendo_msj: .asciiz "Ingresa el dividendo:  "
div_msj: .asciiz "La division es: "
error_msj: .asciiz "No se puede dividir entre 0 "
salto: .asciiz "\n"

.text
.globl main

main:
	
obtener_numeros:
	#obtiene el divsor
	li $v0, 4 #imprime string
    	la $a0, divisor_msj #carga primer numero
    	syscall
    	
  	#guarda el float en f2
	li $v0, 6 #lo guarda en f0
    	syscall
    	mov.s $f2, $f0
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
	
	#obtiene el dividendo
	li $v0, 4 #imprime string
    	la $a0, dividendo_msj #carga segundo numero
    	syscall
    	
  	#guarda el float en f2
	li $v0, 6 #lo guarda en f0
    	syscall
    	mov.s $f3, $f0
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
	
pasar_float_a_int:
	
	cvt.w.s $f2, $f2 # redondeo a entero más cercano
	mfc1 $t0, $f2 #toma la parte entera
    	cvt.w.s $f3, $f3  # redondeo a entero más cercano
	mfc1 $t1, $f3 #toma la parte entera
	
obtener_divison:
	beqz $t0, error #t0=0 -> error
    	div $t2, $t1, $t0  # $t2 = $t1 / $t0
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