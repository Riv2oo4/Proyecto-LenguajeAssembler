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

.code
main proc
    push ebp
    mov ebp, esp

    push offset pregunta	; Imprimir mensaje
    call printf

    push offset respuestaA	; Imprimir mensaje
    call printf
    
    push offset respuestaB
    call printf

    push offset respuestaC
    call printf

    lea  eax, strBuff 		; Obtener dirección del buffer
    push eax 				; Empujar dirección a la pila
    push offset fmt 		; Empujar formato a la pila
    call scanf 				; Leer cadena desde la entrada estándar

    push offset strBuff 	; Empujar cadena a la pila
    push offset resultMsg 	; Empujar formato a la pila
    call printf 			; Imprimir resultado

    add esp, 8 				; Limpiar la pila

  ; Comparar respuesta ingresada con la respuesta correcta
    mov esi, offset strBuff            ; Puntero a la cadena ingresada
    mov edi, offset respuesta1Correcta     ; Puntero a la respuesta correcta

    cmpsb                                               ; Compara byte por byte

    jne respuestaNoIgual                   ; Salta si no son iguales

 ; Incrementar el puntaje en 10 si la respuesta es correcta
    mov eax, [puntaje]
    add eax, 10
    mov [puntaje], eax

    push offset igualMsg
    call printf                                         ; Imprimir mensaje si son iguales
    jmp mostrarPuntaje

respuestaNoIgual:
    push offset noIgualMsg
    call printf                                         ; Imprimir mensaje si no son iguales

mostrarPuntaje:
 ; Imprimir el puntaje
    push offset puntajeMsg
    push dword ptr [puntaje]
    call printf                                          ; Imprimir puntaje

finComparacion:
    mov esp, ebp
    pop ebp
    
    push 0

    ret
main endp

end
