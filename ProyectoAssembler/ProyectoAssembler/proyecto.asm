; Universidad Del Valle De Guatemala
; Alexis Mesias 22562
; Hugo Rivas 22500
; Catedratico: Roger
; Descripcion: Proyecto Assembler
; Fecha: 02/06/2023


includelib libcmt.lib
includelib libvcruntime.lib
includelib libucrt.lib
includelib legacy_stdio_definitions.lib
.model flat, C

printf proto C : VARARG
scanf proto C : VARARG

.data
    i byte 0
    puntaje DWORD 0
    bienvenida byte "Bienvenido al programa de triva TRIVIAMA5T3R3000 en donde ganaras 10 millones de dolares por cada pregunta acertada",0Ah,0

    pregunta byte "¿Cual es la capital de Guatemala?", 0Ah, 0
    respuestaA byte "a) China",0Ah,0
    respuestaB byte "b) Japon",0Ah,0
    respuestaC byte "c) Guatemala",0Ah,0
    respuestaD byte "d) Antigua Guatemala",0Ah,0
    respuesta1Correcta byte "c",0Ah,0
    strBuff BYTE 255 DUP(?) ; Buffer para almacenar la cadena ingresada, máx 255 caracteres
    resultMsg BYTE 'La respuesta ingresada es: %s', 0Ah, 0
    igualMsg BYTE "La respuesta es igual a la correcta", 0Ah, 0
    noIgualMsg BYTE "La respuesta no es igual a la correcta", 0Ah, 0
    puntajeMsg BYTE "Tu puntaje es: %d", 0Ah, 0
    fmt db "%s",0
    pregunta2 byte "¿Cuantos caballos de fuerza tiene el Bugatti Chiron?", 0Ah, 0
    respuesta2A byte "a) 1600",0Ah,0
    respuesta2B byte "b) 1800",0Ah,0
    respuesta2C byte "c) 1650",0Ah,0
    respuesta2D byte "d) 1625",0Ah,0
    respuesta2Correcta byte "a",0Ah,0
    pregunta3 byte "¿Qué elemento quimico tiene el simbolo Au en la tabla periodica?",0Ah,0
    respuesta3A byte "a) Aluminio",0Ah,0
    respuesta3B byte "b) Aurum",0Ah,0
    respuesta3C byte "c) Argon",0Ah,0
    respuesta3D byte "d) Hierro",0Ah,0
    respuesta3Correcta byte "b",0Ah,0
    pregunta4 byte "¿Quien pinto La ultima Cena?",0Ah,0
    respuesta4A byte "a) Vincent Van Gogh",0Ah,0
    respuesta4B byte "b) Michelangelo",0Ah,0
    respuesta4C byte "c) Leonardo da Vinci",0Ah,0
    respuesta4D byte "d) Bob Marley"
    respuesta4Correcta byte "c",0Ah,0
    continuarMsg BYTE "¿Deseas continuar? (s/n)", 0Ah, 0
    continuarRespuesta BYTE 255 DUP(?) ; Buffer para almacenar la respuesta a continuar
    winnerMsg BYTE "¡Felicidades! Ganaste $%d", 0Ah, 0
    loserMsg BYTE "Juego terminado. Perdiste $%d en la pregunta '%s'. Tu respuesta fue '%s', pero la respuesta correcta era '%s'", 0Ah, 0
    pregunta5 byte "¿Como se llama nuestro profesor de Assembler?", 0Ah, 0

    respuesta5A byte "a) Roger",0Ah,0
    respuesta5B byte "b) Douglas",0Ah,0
    respuesta5C byte "c) Linett",0Ah,0
    respuesta5d byte "d) Juan Carlos",0Ah,0
    respuesta5Correcta byte "a",0Ah,0

.code
main proc
    push ebp
    mov ebp, esp
    ; Bienvenida
    push offset bienvenida
    call printf
    push offset continuarMsg
    call printf

    lea eax, continuarRespuesta
    push eax
    push offset fmt
    call scanf
    add esp, 8
    cmp byte ptr [continuarRespuesta], 'n'
    je finComparacion


    ; Primera pregunta
    push offset pregunta
    call printf

    push offset respuestaA
    call printf

    push offset respuestaB
    call printf

    push offset respuestaC
    call printf
    
    push offset respuestaD
    call printf 

    lea eax, strBuff
    push eax
    push offset fmt
    call scanf

    add esp, 8

    mov esi, offset strBuff
    mov edi, offset respuesta1Correcta
    cmpsb
    jne respuestaNoIgual

    mov eax, [puntaje]
    add eax, 10
    mov [puntaje], eax

    push offset igualMsg
    call printf
    jmp mostrarPuntaje

respuestaNoIgual:
    push offset noIgualMsg
    call printf
    jmp gameOver

    gameOver:
    ; Si una pregunta fue contestada incorrectamente, mostrar el mensaje de perdedor
    push offset respuesta1Correcta
    push offset strBuff
    push offset pregunta
    push dword ptr [puntaje]
    push offset loserMsg
    call printf
    add esp, 20
    ret

mostrarPuntaje:
    push dword ptr [puntaje]
    push offset puntajeMsg
    call printf
    add esp, 8

    push offset continuarMsg
    call printf

    lea eax, continuarRespuesta
    push eax
    push offset fmt
    call scanf
    add esp, 8

cmp byte ptr [continuarRespuesta], 'n'
je finComparacion

; Segunda pregunta
push offset pregunta2
call printf

push offset respuesta2A
call printf

push offset respuesta2B
call printf

push offset respuesta2C
call printf

push offset respuesta2D
call printf

lea eax, strBuff
push eax
push offset fmt
call scanf
add esp, 8

mov esi, offset strBuff
mov edi, offset respuesta2Correcta
cmpsb
jne respuesta2NoIgual

mov eax, [puntaje]
add eax, 10
mov [puntaje], eax

push offset igualMsg
call printf
jmp mostrarPuntaje2

respuesta2NoIgual:
push offset noIgualMsg
call printf
jmp gameOver2

    gameOver2:
    ; Si una pregunta fue contestada incorrectamente, mostrar el mensaje de perdedor
    push offset respuesta2Correcta
    push offset strBuff
    push offset pregunta2
    push dword ptr [puntaje]
    push offset loserMsg
    call printf
    add esp, '20'
    
    ret

mostrarPuntaje2:
push dword ptr [puntaje]
push offset puntajeMsg
call printf
add esp, 8

    push offset continuarMsg
    call printf

    

    lea eax, continuarRespuesta
    push eax
    push offset fmt
    call scanf
    add esp, 8

cmp byte ptr [continuarRespuesta], 'n'
je finComparacion

    ; Tercera pregunta
    push offset pregunta3
    call printf

    push offset respuesta3A
    call printf

    push offset respuesta3B
    call printf

    push offset respuesta3C
    call printf

    push offset respuesta3D
    call printf

    lea eax, strBuff
    push eax
    push offset fmt
    call scanf

    add esp, 8

    mov esi, offset strBuff
    mov edi, offset respuesta3Correcta
    cmpsb
    jne respuesta3NoIgual

    mov eax, [puntaje]
    add eax, 10
    mov [puntaje], eax

    push offset igualMsg
    call printf
    jmp mostrarPuntaje3

respuesta3NoIgual:
    push offset noIgualMsg
    call printf
    jmp gameOver3

    gameOver3:
    ; Si una pregunta fue contestada incorrectamente, mostrar el mensaje de perdedor
    push offset respuesta3Correcta
    push offset strBuff
    push offset pregunta3
    push dword ptr [puntaje]
    push offset loserMsg
    call printf
    add esp, 20
    ret

mostrarPuntaje3:
    push dword ptr [puntaje]
    push offset puntajeMsg
    call printf
    add esp, 8

    


    push offset continuarMsg
    call printf

    lea eax, continuarRespuesta
    push eax
    push offset fmt
    call scanf
    add esp, 8

cmp byte ptr [continuarRespuesta], 'n'
je finComparacion
    ; Cuarta pregunta
    push offset pregunta4
    call printf

    push offset respuesta4A
    call printf

    push offset respuesta4B
    call printf

    push offset respuesta4C
    call printf

    push offset respuesta4D
    call printf

    lea eax, strBuff
    push eax
    push offset fmt
    call scanf

    add esp, 8

    mov esi, offset strBuff
    mov edi, offset respuesta4Correcta
    cmpsb
    jne respuesta4NoIgual

    mov eax, [puntaje]
    add eax, 10
    mov [puntaje], eax

    push offset igualMsg
    call printf
    jmp mostrarPuntaje4


respuesta4NoIgual:
    push offset noIgualMsg
    call printf
    jmp gameOver4

    gameOver4:
    ; Si una pregunta fue contestada incorrectamente, mostrar el mensaje de perdedor
    push offset respuesta4Correcta
    push offset strBuff
    push offset pregunta4
    push dword ptr [puntaje]
    push offset loserMsg
    call printf
    add esp, 20
    ret

mostrarPuntaje4:
    push dword ptr [puntaje]
    push offset puntajeMsg
    call printf
    add esp, 8

        push offset continuarMsg
    call printf

    lea eax, continuarRespuesta
    push eax
    push offset fmt
    call scanf
    add esp, 8

cmp byte ptr [continuarRespuesta], 'n'
je finComparacion


; Quinta pregunta
    push offset pregunta5
    call printf

    push offset respuesta5A
    call printf

    push offset respuesta5B
    call printf

    push offset respuesta5C
    call printf

    push offset respuesta5D
    call printf

    lea eax, strBuff
    push eax
    push offset fmt
    call scanf

    add esp, 8

    mov esi, offset strBuff
    mov edi, offset respuesta5Correcta
    cmpsb
    jne respuesta5NoIgual

    mov eax, [puntaje]
    add eax, 10
    mov [puntaje], eax

    push offset igualMsg
    call printf
    jmp mostrarPuntaje5


respuesta5NoIgual:
    push offset noIgualMsg
    call printf
    jmp gameOver5

    gameOver5:
    ; Si una pregunta fue contestada incorrectamente, mostrar el mensaje de perdedor
    push offset respuesta4Correcta
    push offset strBuff
    push offset pregunta5
    push dword ptr [puntaje]
    push offset loserMsg
    call printf
    add esp, 20
    ret

mostrarPuntaje5:
    push dword ptr [puntaje]
    push offset puntajeMsg
    call printf
    add esp, 8

    ; Si todas las preguntas fueron contestadas correctamente, mostrar el mensaje de ganador
    push dword ptr [puntaje]
    push offset winnerMsg
    call printf
    add esp, 8
    jmp finComparacion

finComparacion:
    mov esp, ebp
    pop ebp

    push 0

    ret
main endp

end










