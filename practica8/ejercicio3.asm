.data
shell: .asciiz "Por fin llegaste hasta aquí, tonoto" #Este mensaje lo pueden modificar.
.text
.globl main
main:
	
	j codigo
	
tesoro:
	li $v0 10 #Terminamos el programa
	syscall
	li $v0, 4 #Cargamos string shell
	la $a0, shell #Direccion de la string shell
	syscall #Imprime el Shell. Si lo logramos imprimir, ganamos.
	li $v0 10 #Terminamos el programa
	syscall
codigo:
	la $t0, tesoro #Guardamos la direccion de tesoro
	addi $t0, $t0, 8 #Nos saltamos las primeras dos instrucciones
	jr $t0 #Saltamos a la nueva direccion
