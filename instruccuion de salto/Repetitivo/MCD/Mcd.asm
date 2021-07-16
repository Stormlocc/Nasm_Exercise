;Nombre			:	Mcd.asm
;Proposito		:	hallar el MCD de 2 numeros
;Autor			:	Anthony Mayron Lopez Oquendo
;FCrecion		:	26 de Junio 2021
;FModifcacion	:	28 de Junio 2021
;Compilacion	:	nasm -f elf Mcd.asm
;Enlace			:	ld -m elf_i386 -s -o Mcd Mcd.o io.o
;Ejecucion		:	./Mcd
;____________________________________________________________________________
%include "io.mac"

section .data
    msg:        db "<<<< MAXIMO COMUN DIVISOR >>>>",10,0
    msgInput:   db "Ingrese numero:",0
    msgOutput:  db "MCD: ",0

section .text
    global _start

_start:
    ;mensaje de app
    PutStr msg

    ;Leer datos
    PutStr msgInput
    GetLInt eax
    PutStr msgInput
    GetLInt ebx

    ;Procesar MCD
    procesar:
    ;While
    cmp eax,ebx
    jz mostrar

        ;IF
        cmp eax,ebx
        js menor
        sub eax,ebx
        jmp procesar
        ;Else
        menor:
        sub ebx,eax
        jmp procesar


    ;Mostrar MCD
    mostrar:
    PutStr msgOutput
    PutLInt eax
    nwln

    ;Regresar al SO
    mov eax,1
    int 80h
