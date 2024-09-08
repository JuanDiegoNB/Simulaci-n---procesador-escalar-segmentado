        .data                               # Secci�n de datos
msg_input:   .asciiz "Ingrese un n�mero: "  
msg_count:   .asciiz "�Cu�ntos n�meros desea comparar (entre 3 y 5)?: "
msg_invalid: .asciiz "Por favor, ingrese un n�mero entre 3 y 5.\n"
msg_result:  .asciiz "El n�mero mayor es: " 

        .text                               # Secci�n de c�digo
        .globl main

main:
        # Preguntar cu�ntos n�meros desea comparar
ask_count:
        li $v0, 4               # Syscall para imprimir string
        la $a0, msg_count       # Cargar el mensaje de cu�ntos n�meros
        syscall

        li $v0, 5               # Syscall para leer entero
        syscall
        move $t4, $v0           # Mover la cantidad ingresada a $t4

        # Verificar si el n�mero est� entre 3 y 5
        li $t5, 3               # M�nimo n�mero permitido
        li $t6, 5               # M�ximo n�mero permitido
        blt $t4, $t5, invalid_count  # Si es menor que 3, volver a pedir
        bgt $t4, $t6, invalid_count  # Si es mayor que 5, volver a pedir
        j start_comparison       # Si es v�lido, proceder con la comparaci�n

invalid_count:
        li $v0, 4               # Imprimir mensaje de n�mero inv�lido
        la $a0, msg_invalid     # Cargar el mensaje de error
        syscall
        j ask_count             # Volver a preguntar cu�ntos n�meros comparar

start_comparison:
        # Inicializar el contador y el mayor n�mero
        li $t0, 0               # Contador de iteraciones
        li $t1, -2147483648     # Inicializar el n�mero mayor con el menor posible

ask_numbers:
        # Pregunta al usuario por el n�mero
        li $v0, 4               # Syscall para imprimir string
        la $a0, msg_input       # Cargar el mensaje para pedir n�mero
        syscall

        li $v0, 5               # Syscall para leer entero
        syscall
        move $t2, $v0           # Mover el n�mero le�do a $t2

        # Comparar si el n�mero ingresado es mayor que el actual mayor
        ble $t2, $t1, skip      # Si $t2 <= $t1, no actualizar el mayor
        move $t1, $t2           # Si $t2 es mayor, actualizar $t1 con $t2

skip:
        addi $t0, $t0, 1        # Incrementar el contador
        blt $t0, $t4, ask_numbers  # Si el contador es menor a la cantidad ingresada, repetir

        # Mostrar el n�mero mayor
        li $v0, 4               # Syscall para imprimir string
        la $a0, msg_result       # Cargar el mensaje del resultado
        syscall

        li $v0, 1               # Syscall para imprimir entero
        move $a0, $t1           # Cargar el n�mero mayor en $a0
        syscall

        # Finalizar el programa
        li $v0, 10              # Syscall para salir
        syscall
