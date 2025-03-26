.text
.globl main

main:

    li $t0, 8  # Guarda el número 8 en el registro $t0
    add $t1, $t0, $zero # le suma 0 a t0 y lo guarda en t1
    
exit:
    li $v0, 10 #sale del programa
    syscall