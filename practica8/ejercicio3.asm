	.data 
shell: .asciiz "loloololo "
	.text
	.global main
main:
	j codigo
	
	
tesoro:
	li $v0 10 #terminamos el programa 
	syscall
	li $v0, 4 #cargamos la string shell
	la $a0, shell #direccion de la string shell
	syscall #imprime el shell. Si lo logramos imprimir ganamos
	li $v0 10 #Terminamos el programa
	syscall
	
codigo: 
	jal tesoro      # salta a 'tesoro', imprime shell y termina
	jr $ra          # regresa (por si acaso, aunque nunca se ejecuta)







