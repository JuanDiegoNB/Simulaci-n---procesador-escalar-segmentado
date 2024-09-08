        .data                               # Secci�n de datos
msg_fib_count:   .asciiz "�Cu�ntos n�meros de la serie Fibonacci desea generar?: "
msg_invalid:     .asciiz "Por favor, ingrese un n�mero mayor que 0.\n"
msg_fib_result:  .asciiz "La serie Fibonacci es: "
msg_fib_sum:     .asciiz "\nLa suma de la serie es: "

        .text                               # Secci�n de c�digo
        .globl main

main:
        # Preguntar cu�ntos n�meros de la serie Fibonacci desea generar
ask_count:
        li $v0, 4               # Syscall para imprimir string
        la $a0, msg_fib_count   # Cargar el mensaje de cu�ntos n�meros
        syscall

        li $v0, 5               # Syscall para leer entero
        syscall
        move $t4, $v0           # Mover la cantidad ingresada a $t4

        # Verificar si el n�mero es mayor que 0
        li $t5, 1               # M�nimo n�mero permitido
        blt $t4, $t5, invalid_count  # Si es menor que 1, volver a pedir
        j start_fibonacci        # Si es v�lido, proceder con la generaci�n

invalid_count:
        li $v0, 4               # Imprimir mensaje de n�mero inv�lido
        la $a0, msg_invalid     # Cargar el mensaje de error
        syscall
        j ask_count             # Volver a preguntar cu�ntos n�meros generar

start_fibonacci:
        # Inicializaci�n de los primeros valores de Fibonacci
        li $t0, 0               # Primer n�mero de Fibonacci (F(0))
        li $t1, 1               # Segundo n�mero de Fibonacci (F(1))
        li $t2, 0               # Variable para el siguiente n�mero en la serie
        li $t3, 0               # Contador de iteraciones
        li $t6, 0               # Acumulador para la suma de la serie

        # Imprimir mensaje de resultado de la serie
        li $v0, 4               # Syscall para imprimir string
        la $a0, msg_fib_result  # Cargar el mensaje de la serie
        syscall

print_fibonacci:
        # Mostrar el valor de Fibonacci actual (t0)
        li $v0, 1               # Syscall para imprimir entero
        move $a0, $t0           # Cargar el n�mero actual de Fibonacci
        syscall

        # Sumar el valor actual a la suma acumulada
        add $t6, $t6, $t0       # Sumar el n�mero actual a la suma total

        # Calcular el siguiente n�mero de Fibonacci
        add $t2, $t0, $t1       # Siguiente n�mero es la suma de los dos anteriores
        move $t0, $t1           # Actualizar F(n-1) con F(n)
        move $t1, $t2           # Actualizar F(n) con el siguiente n�mero

        # Incrementar el contador
        addi $t3, $t3, 1

        # Verificar si ya se generaron todos los n�meros
        blt $t3, $t4, print_fibonacci  # Si el contador es menor a $t4, continuar la serie

        # Imprimir la suma de la serie
        li $v0, 4               # Syscall para imprimir string
        la $a0, msg_fib_sum     # Cargar el mensaje de la suma
        syscall

        li $v0, 1               # Syscall para imprimir entero
        move $a0, $t6           # Cargar la suma total en $a0
        syscall

        # Finalizar el programa
        li $v0, 10              # Syscall para salir
        syscall
