.data
mensaje: .asciiz "For en MIPS \n"
enter: .asciiz "Ingresa un numero: "
num: .word 0

.text
main:
    # Imprimir mensaje de entrada
    li $v0, 4
    la $a0, enter
    syscall

    # Leer número del usuario
    li $v0, 5
    syscall
    sw $v0, num  # Guardar el número ingresado

    # Cargar número en $t2
    lw $t2, num  

    # Inicializar contador $t0 en 0
    li $t0, 0

loop:
    # Si $t0 == $t2, salir del bucle
    beq $t0, $t2, end  

    # Imprimir mensaje
    li $v0, 4
    la $a0, mensaje
    syscall

    # Incrementar contador
    addi $t0, $t0, 1  

    # Repetir el bucle
    j loop  

end:
    # Terminar el programa
    li $v0, 10
    syscall
