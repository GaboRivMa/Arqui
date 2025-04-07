.data
mensaje: .asciiz "Ingresa un valor para m: "
uno: .float 1.0
menos_uno: .float -1.0
dos: .float 2.0
cuatro: .float 4.0
cero: .float 0.0

.text
.globl main

main:
    # Mostrar mensaje
    li $v0, 4
    la $a0, mensaje
    syscall

    # Leer entero
    li $v0, 5
    syscall
    move $s0, $v0# Guardar m en $s0

    # Inicializar n y suma
    li $t0, 0 # n = 0
    l.s $f2, cero # sum = 0.0
   
#Suma
loop:
    bge $t0, $s0, fin #si n >= m: salir del loop

    # Guardar n en $a0
    move $a0, $t0

    # Llamar a calcular (-1)^n
    jal potencia_neg_uno  # resultado en $f4

    # Llamar a calcular término: (-1)^n / (2n + 1)
    mov.s $f6, $f4 # guardar signo en $f6
    jal termino # resultado en $f4

    # sum += término
    add.s $f2, $f2, $f4

    addi $t0, $t0, 1 # n += 1
    j loop
    
#Potencia de -1
potencia_neg_uno:
    andi $t1, $a0, 1 # n % 2
    beq $t1, $zero, pos
    l.s $f4, menos_uno # impar, entonces -1
    jr $ra
pos:
    l.s $f4, uno # par, entonces 1
    jr $ra
    
    
termino:
    # Entrada: $a0 = n, signo en $f6
    mul $t2, $a0, 2
    addi $t2, $t2, 1 # 2n + 1

    mtc1 $t2, $f8
    cvt.s.w $f8, $f8 #convertir a float

    div.s $f4, $f6, $f8 # término = signo / (2n + 1)
    jr $ra
    
fin:
    l.s $f10, cuatro
    mul.s $f12, $f2, $f10 # resultado final en $f12

    li $v0, 2 # syscall imprimir float
    syscall

    li $v0, 10
    syscall




