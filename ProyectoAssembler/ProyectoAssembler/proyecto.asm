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
    pregunta byte "¿Cual es la capital de Guatemala?", 0Ah, 0
    respuestaA byte "a) China",0Ah,0
    respuestaB byte "b) Japon",0Ah,0
    respuestaC byte "c) Guatemala",0Ah,0
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
    respuesta2Correcta byte "a",0Ah,0
    pregunta3 byte "¿¿Qué elemento químico tiene el símbolo "Au" en la tabla periódica?"
    respuesta3A byte "a) Aluminio",0Ah,0
    respuesta3B byte "b) Aurum",0Ah,0
    respuesta3C byte "c) Argon",0Ah,0
    respuesta3Correcta byte "b",0Ah,0
    pregunta4 byte "¿Quien pinto "La ultima Cena"?"
    respuesta4A byte "a) Vincent Van Gogh",0Ah,0
    respuesta4B byte "b) Michelangelo",0Ah,0
    respuesta4C byte "c) Leonardo da Vinci",0Ah,0
    respuesta4Correcta byte "c",0Ah,0
    continuarMsg BYTE "¿Deseas continuar? (s/n)", 0Ah, 0
    continuarRespuesta BYTE 255 DUP(?) ; Buffer para almacenar la respuesta a continuar


.code
main proc
    push ebp
    mov ebp, esp

    ; Primera pregunta
    push offset pregunta
    call printf

    push offset respuestaA
    call printf

    push offset respuestaB
    call printf

    push offset respuestaC
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

mostrarPuntaje:
    push dword ptr [puntaje]
    push offset puntajeMsg
    call printf
    add esp, 8

    ; Segunda pregunta
    push offset pregunta2
    call printf

    push offset respuesta2A
    call printf

    push offset respuesta2B
    call printf

    push offset respuesta2C
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

mostrarPuntaje2:
    push dword ptr [puntaje]
    push offset puntajeMsg
    call printf
    add esp, 8

finComparacion:
    mov esp, ebp
    pop ebp
    
    push 0

    ret
main endp

end


