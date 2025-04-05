.data
divisor_msj: .asciiz "Ingresa el divisor:  "
dividendo_msj: .asciiz "Ingresa el dividendo:  "
division_msj: .asciiz "La division es: "
error1_msj: .asciiz "No se puede dividir entre 0 "
salto: .asciiz "\n"
cero: .float 0.0

.text
.globl main

main:
	l.s $f4, divisor #carga el divisor
	
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
	mfc1 $t0, $f3 #toma la parte entera
	
obtener_divison:



error:	
    	li $v0, 4
    	la $a0, error_msj
    	syscall

exit:
    	li $v0, 10 #sale del programa
    	syscall