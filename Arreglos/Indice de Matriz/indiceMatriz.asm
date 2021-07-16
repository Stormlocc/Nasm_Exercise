;Nombre			:	indiceMatriz.asm
;Proposito		:	indiceMatriz de multiplo de 13 de la matriz
;Autor			:	Anthony Mayron Lopez Oquendo
;FCrecion		:	11 de Julio 2021
;FModificacion	:	11 de Julio 2021
;Compilacion	:	nasm -f elf indiceMatriz.asm
;Enlace			:	ld -m elf_i386 -s -o indiceMatriz indiceMatriz.o io.o
;Ejecucion		:	./indiceMatriz
;____________________________________________________________________________

%include "io.mac"

section .data
    msg         db " <<<BUSCAR INDICE EN MATRIZ>>> " ,10,0
    msgFila     db "Ingrese M (fila): ",0
    msgColumna    db "Ingrese N (columna) : ",0
    salida      db "Los elementos de la matriz : ",10,0
    imprimirTab db "",9,0
    imprimirEsp db " ",0
    invitacion  db "Ingrese el elemento ", 0
    pedirDatos  db " de la matriz: ", 0
    arregloVacio db "El vector esta vacio. ",0
    pregunta    db "Terminar? (S/N): ",0
    msgPosicion db "Indice 13° es : ",0

section .bss
    arreglo resd 1000
    fila resd 1
    columna resd 1
    auxFila resd 1
    auxColm resd 1
section .text
    global _start

_start:
    PutStr msg
    leer_datos:
        xor esi,esi         ; ESI = 0 (ESI se utiliza como indice)
        xor edx,edx
        PutStr msgFila      ; solicitar datos
        GetLInt eax
        mov [fila],eax
        PutStr msgColumna
        GetLInt eax
        mov [columna],eax
        mov ebx,1       ;contadorFila
        
    leer_filas:
        mov ecx,1       ;contador Columna
        leer_columnas:
            ;Input datos
            PutStr invitacion
            PutLInt ebx             ;fila
            PutStr imprimirEsp
            PutLInt ecx             ;columna
            PutStr pedirDatos
            GetLInt eax
            ;Asignar input a memoria
            mov [arreglo+ESI*4], eax
            inc esi
            inc ecx
            cmp ecx,[columna]      
            jna leer_columnas       ;menor 
        inc ebx
        cmp ebx,[fila]              
        jna leer_filas              ;menor
    
    continunado:
    PutStr salida
    mov ecx,esi
    xor esi,esi

    mostrar_siguiente:              ; Mostrar matriz
        PutLInt [arreglo+ESI*4]
        PutStr imprimirEsp
        inc esi
        xor edx,edx
        mov eax,esi
        mov ebx,[columna]
        div ebx
        cmp edx,0
        jnz continuarr
        nwln
        continuarr:
        loop mostrar_siguiente      ;ecx se va decrementando
        mov ecx,esi                 ;ecx <- esi
        xor esi,esi
        mov [auxFila],esi           ;asignando 0 a auxiluares
        mov [auxColm],esi

    ;____________________________________________________________________
    buscar_filas:
        xor eax,eax
        mov ebx,13
        mov [auxColm],eax       ;contador Columna
        buscar_columnas:
            mov eax,[arreglo+esi*4]     ;Obtener elmto
            xor edx,edx               ;Determinar si es multiplo de 13
            div ebx                     ;dividir 13
            
            cmp edx,0
            jnz aea                     ;02
            ;Mostrar posicion
            PutStr msgPosicion
            PutLInt [auxFila]
            PutStr imprimirEsp
            PutLInt [auxColm]
            nwln
            aea:
            ;incrementar contadores
            inc esi
            mov eax,1
            add [auxColm],eax           ;incrementar columna
            mov eax,[auxColm]
            cmp eax,[columna]       
            jnae buscar_columnas        ;menor 
        mov eax,1
        add [auxFila],eax
        mov eax,[auxFila]
        cmp eax,[fila]              
        jnae buscar_filas               ;menor

    preguntar:
        nwln
        PutStr pregunta ; preguntar al usuario si desea terminar
        GetCh AL
        cmp AL,'S' ; si la respuesta no es 'S'
        ;Auxiliar en 0
        jne leer_datos ; repetir el bucle si es distinto cmp
    
    terminado:

;volver al sistema
mov eax,1
int 80h


