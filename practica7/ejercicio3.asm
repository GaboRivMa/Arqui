.data
a_msj: .asciiz "Ingresa el valor de a:  "
b_msj: .asciiz "Ingresa el valor de b:  "
c_msj: .asciiz "Ingresa el valor de c:  "
x1_msj: .asciiz "x1: "
x2_msj: .asciiz "x2: "
error1_msj: .asciiz "No se puede dividir entre 0 "
error2_msj: .asciiz "No existe una solución real"
salto: .asciiz "\n"
cero: .double 0.0
dos: .double 2.0
cuatro: .double 4.0
menos_uno: .double -1.0

.text
.globl main

main:
	ldc1 $f8, cero #carga la cte 0
	ldc1 $f10, dos  #carga la cte 2
	ldc1 $f12, cuatro #carga la cte 4
	ldc1 $f14, menos_uno #carga la cte -1
	
obtener_numeros:
	#-----------obtiene el valor de a
	li $v0, 4 #imprime string
    	la $a0, a_msj #carga primer numero
    	syscall
    	
  	#guarda el double en f2
	li $v0, 7 #lo guarda en f0
    	syscall
    	mov.d $f2, $f0
    	
    	#Verifica que a no sea cero
    	c.eq.d $f2, $f8 #a==0
    	bc1t error1 
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
    	
    	#-----------obtiene el valor de b
	li $v0, 4 #imprime string
    	la $a0, b_msj #carga primer numero
    	syscall
    	
  	#guarda el double en f2
	li $v0, 7 #lo guarda en f0
    	syscall
    	mov.d $f4, $f0
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
    	
    	#-----------obtiene el valor de c
	li $v0, 4 #imprime string
    	la $a0, c_msj #carga primer numero
    	syscall
    	
  	#guarda el double en f2
	li $v0, 7 #lo guarda en f0
    	syscall
    	mov.d $f6, $f0
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
    	
obtener_raiz:
	mul.d $f16, $f4, $f4   # f16 = b^2
	mul.d $f18, $f2, $f6   # f16 = a*c
	mul.d $f18, $f12, $f18 # f16 = 4*a*c
	sub.d $f18, $f16, $f18 # f16 = f14(b^2) - f16(4ac)
    	
    	#Verifica que a no sea raiz imaginaria
    	c.lt.d $f18, $f8 #b^2-4ac < 0
    	bc1t error2 
    	
    	#saca la raiz
    	sqrt.d $f18, $f18 #f16 = sqrt(b^2-4ac)

obtener_solucion:
	mul.d $f4, $f4, $f14   # f4 = -b
   	mul.d $f20, $f10, $f2   # f20 = 2a

	#obtiene x1
    	add.d $f22, $f4, $f18 # f22 = -b +  sqrt(b^2 - 4ac)
    	div.d $f24, $f22, $f20 # x1 = f22 / f20
    	
    	#obtiene x2
    	sub.d $f22, $f4, $f18 # f22 = -b -  sqrt(b^2 - 4ac)
    	div.d $f26, $f22, $f20 #x2 = f22 / f20
    	
imprimir_solucion:
	#imprime x1    	    	
 	li $v0, 4                
    	la $a0, x1_msj
    	syscall
	
    	li $v0, 3                 
    	mov.d $f12, $f24            
    	syscall
    	
    	#imprime salto de línea
    	li $v0, 4
    	la $a0, salto
    	syscall
    	
    	#imprime x2   	    	
 	li $v0, 4                
    	la $a0, x2_msj
    	syscall
	
    	li $v0, 3                 
    	mov.d $f12, $f26            
    	syscall
    	
    	j exit 
    	
error1:	
    	li $v0, 4
    	la $a0, error1_msj
    	syscall    
    	j exit
    		
error2:	
    	li $v0, 4
    	la $a0, error2_msj
    	syscall       

exit:
    	li $v0, 10 #sale del programa
    	syscall	

 

