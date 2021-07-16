;Nombre			:	buscarElemento.asm
;Proposito		:	buscarElemento en un vector de N elementos
;Autor			:	Anthony Mayron Lopez Oquendo
;FCrecion		:	11 de Julio 2021
;FModificacion	:	11 de Julio 2021
;Compilacion	:	nasm -f elf buscarElemento.asm
;Enlace			:	ld -m elf_i386 -s -o buscarElemento buscarElemento.o io.o
;Ejecucion		:	./buscarElemento
;____________________________________________________________________________

%include "io.mac"
section .data
    msg         db " <<<BUSCAR ELEMENTO EN EL ARREGLO>>> " ,10,0
    entrada     db "Ingrese valores diferentes de cero ",13
                db "(si ingresa cero, termina la lectura de datos):",10, 0
    salida      db "Los elementos del vector son: ",10,0
    imprimirTab db "",9,0
    invitacion  db "Ingrese el elemento ", 0
    pedirDatos  db " del vector: ", 0
    arregloVacio db "El vector esta vacio. ",0
    pregunta    db "Terminar? (S/N): ",0
    msgElemento db "Ingrese elemento a buscar: ",0
    msgUbicado  db "Elemento encontrado en el vector, finalizo" ,10,0
    msgNoUbicado db "Elemento NO ubicado, vuelva a intentar", 10,0
    msgN        db "Ingrese la cantidad de elementos del vector: ",0


section .bss
    arreglo resd 1000
section .text
    global _start

_start:
    PutStr msg
    leer_datos:
        PutStr entrada ; solicitar datos
        xor esi,esi ; ESI = 0 (ESI se utiliza como indice)
        ;Ingresar la cantidad de elementos
        PutStr msgN
        GetLInt ecx
    leer_siguiente:
        ;Input datos
        PutStr invitacion
        PutLInt esi
        PutStr pedirDatos
        GetLInt eax
        ;Asignar input a memoria
        mov [arreglo+esi*4],eax
        inc esi ; incrementar indice de arreglo
        cmp eax,0 ; se ingreso un cero?
        loopne leer_siguiente ; iterar no mas de MAX_SIZE veces (ecx)
        ;Loopne trabaja con ecx registor contador y la bandera (Si se ingreso 0)
        ;Loopne->  if(cmp != 0 and ecx>esi)
    exit_loop:
        jnz omitir  ;sino ingreso 0  saltar
        dec esi     ; si ingreso 0 descontar
    omitir:
        mov ecx, esi ; esi almacena el tamaño del arreglo 
                        ;(si es que se agrego menos de 7)
        jecxz arreglo_Vacio ; si ecx = 0, el arreglo esta vacio saltar a__ 
        xor esi,esi ; inicializar indice a cero
        PutStr salida
    mostrar_siguiente:
        PutLInt [arreglo+ESI*4]
        PutStr imprimirTab
        inc esi
        loop mostrar_siguiente      ;ecx se va decrementando
        mov ecx ,esi                ;ecx obtiene la cantidad de elementos
        jmp short pedir_elemento
    arreglo_Vacio:
        PutStr arregloVacio ; mostrar mensaje de arreglo vacio
        nwln
        jmp preguntar

    pedir_elemento:
        nwln
        ;Contador en 0
        xor esi,esi
        ;Ingresar el elemento
        PutStr msgElemento
        GetLInt eax
    
    buscar_elemento:
        ;Buscar el elemento
        cmp eax , [arreglo+ESI*4]
        jz encontrado
        inc esi
        loopne buscar_elemento
    
    no_encontrado:
    PutStr msgNoUbicado
    mov ecx ,esi
    ;xor esi,esi
    jmp pedir_elemento

    encontrado:
    PutStr msgUbicado
    jmp preguntar

    preguntar:
        nwln
        PutStr pregunta ; preguntar al usuario si desea terminar
        GetCh AL
        cmp AL,'S' ; si la respuesta no es 'S'
        jne leer_datos ; repetir el bucle si es distinto cmp
    
    terminado:

;volver al sistema
mov eax,1
int 80h