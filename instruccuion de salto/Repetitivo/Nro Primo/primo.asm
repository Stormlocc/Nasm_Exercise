;Nombre			:	primo.asm
;Proposito		:	determinar si un numero es primo
;Autor			:	Anthony Mayron Lopez Oquendo
;FCrecion		:	27 de Junio 2021
;FModificacion	:	27 de Junio 2021
;Compilacion	:	nasm -f elf primo.asm
;Enlace			:	ld -m elf_i386 -s -o primo primo.o io.o
;Ejecucion		:	./primo
;____________________________________________________________________________

%include "io.mac"

section .data
    msg:        db "<<<< DETERMINAR SI UN NUMERO ES PRIMO >>>>",10,0
    msgInput:   db "Ingrse un numero: ",0
    msgPrimo:   db "Es primo",10,0
    msgNoprimo: db "No es primo",10,0
    debug1:      db "nro a: ",0
    debugd:      db "nro d: ",0
    debug3:      db "nro contador: ",0

section .bss
    nro resw 1

section .text
    global _start

_start:
    PutStr msg
    mov ecx,2   ;m = c
    ;Ingresar numero
    PutStr msgInput
    GetLInt [nro]

    ;Determina si es primo
    procesar:
    ;While
    cmp [nro],ecx
    jz Primo
        mov eax,[nro]
        mov edx,0
        div ecx

        cmp edx,0
        jz Fin
        inc ecx
        jmp procesar

    ;Mensaje
    Fin:
    PutStr msgNoprimo
    jmp Final
    Primo:
    PutStr msgPrimo

    Final:
    ;Regresar al sitema
    mov eax,1
    int 80h
