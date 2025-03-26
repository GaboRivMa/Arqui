.data
texto: .asciiz "Hola mundo\n"
mensaje: .asciiz "Ingresa un numero: "

.text
.globl main

main:
    li $v0, 4 #imprime string
    la $a0, mensaje #carga el numero
    syscall

    li $v0, 5 #entrada de tipo int mientras el programa se ejecuta, el número se guarda en v0
    syscall
    move $t0, $v0   # Guardar el número en t0 

loop: 
    beqz $t0, exit   # Si $t0 es 0 termina el programa

    li $v0, 4 #imprime string
    la $a0, texto #carga el mensaje
    syscall

    subi $t0, $t0 1 #le resta 1 al numero   

    j loop  # Repetir el loop

exit:
    li $v0, 10 #sale del programa
    syscall
