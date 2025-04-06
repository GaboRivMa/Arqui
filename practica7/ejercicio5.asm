.data

fg_msj: .asciiz "Fuerza gravitacional entre la Luna y la Tierra: "
G: .double 6.674e-11 #cte gravitacional
m1: .double 5.98e24 #masa de la Tierra
m2: .double 7.34e22 #masa de la Luna
r: .double 384e6 #distancia entre la Tierra y la Luna 
salto:  .asciiz "\n"

.text
.globl main

main:
	#carga todas las ctes
	ldc1 $f2, G
	ldc1 $f4, m1
	ldc1 $f6, m2
	ldc1 $f8, r
	
	#calcula la fuerza gravitacional
	mul.d $f10, $f4, $f6 # f10 = m1*m2
	mul.d $f12, $f8, $f8 # f12 = r*r
	div.d $f10, $f10, $f12 # f10 = m1*m2 /  r*r
	mul.d $f10, $f2, $f10 # f10 = G (m1*m2 /  r*r)
	
    	#imprime la solucion	
 	li $v0, 4                
    	la $a0, fg_msj
    	syscall
	
    	li $v0, 3                 
    	mov.d $f12, $f10            
    	syscall
    	
exit:
    	li $v0, 10 #sale del programa
    	syscall	
