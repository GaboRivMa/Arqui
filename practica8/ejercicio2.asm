.data
n:        .word 4
k:        .word 2
mensaje:  .asciiz "El coeficiente binomial es: "
llamada:  .asciiz "\nLlamada a C("
coma:     .asciiz ", "
cierra:   .asciiz ")"

.text
main:
    lw  $a0, n              # Cargar n
    lw  $a1, k              # Cargar k
    jal coef_bin            # Llamar a la función recursiva
    move $s0, $v0           # Guardar el resultado en $s0

    li   $v0, 4
    la   $a0, mensaje       # Imprimir el mensaje
    syscall

    move $a0, $s0           # Imprimir el resultado
    li   $v0, 1
    syscall

    j exit

coef_bin:
    # PILA
    addi $sp, $sp, -12      # Reservar espacio en la pila
    sw   $ra, 0($sp)        # Guardar el valor de $ra (dirección de retorno)
    sw   $a0, 4($sp)        # Guardar n en la pila
    sw   $a1, 8($sp)        # Guardar k en la pila

    # Casos base
    beqz $a1, caso_base     # Si k == 0, el resultado es 1
    beq  $a0, $a1, caso_base # Si n == k, el resultado es 1

    # Calcular (n-1, k-1)
    subi $a0, $a0, 1        # n = n-1
    subi $a1, $a1, 1        # k = k-1
    jal coef_bin            # Llamada recursiva para (n-1, k-1)
    move $t0, $v0           # Guardar el resultado de (n-1, k-1) en $t0

    # Restaurar valores de n y k para la siguiente llamada
    lw   $a0, 4($sp)        # Restaurar n
    lw   $a1, 8($sp)        # Restaurar k

    # Calcular (n-1, k)
    subi $a0, $a0, 1        # n = n-1
    jal coef_bin            # Llamada recursiva para (n-1, k)
    move $t1, $v0           # Guardar el resultado de (n-1, k) en $t1

    # Sumar los resultados de (n-1, k-1) y (n-1, k)
    add $v0, $t0, $t1       # El resultado final es la suma de los dos casos

    # Restaurar los valores de la pila
    lw $ra, 0($sp)          # Recuperar el valor de $ra
    lw $a0, 4($sp)          # Recuperar el valor de n
    lw $a1, 8($sp)          # Recuperar el valor de k
    addi $sp, $sp, 12       # Liberar espacio en la pila

    jr $ra                  # Volver a la función que llamó a coef_bin

caso_base:
    li $v0, 1               # Si k == 0 o n == k, el coeficiente es 1

    # Restaurar los valores de la pila
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    addi $sp, $sp, 12

    jr $ra                  # Volver a la función que llamó a coef_bin

exit:
    li $v0, 10
    syscall
