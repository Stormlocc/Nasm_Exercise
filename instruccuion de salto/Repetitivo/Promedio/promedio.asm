;Nombre			:	promedio.asm
;Proposito		:	Escriba un programa que lea 3 notas de un alumno,
;calcule su promedio 
;y de acuerdo a este indique si el alumno esta reprobado, desaprobado, 
;aprobado o es sobresaliente. Las notas deben ingresarse en tiempo de 
;ejecución.
;Autor			:	Anthony Mayron Lopez Oquendo
;FCrecion		:	23 de Junio 2020
;FModificacion	:	23 de Junio 2020
;Compilacion	:	nasm -f elf promedio.asm
;Enlace			:	ld -m elf_i386 -s -o promedio promedio.o io.o
;Ejecucion		:	./promedio
;____________________________________________________________________________
;10 fin de linea
;0 obliga a que el cursos se quede en linea
%include "io.mac"

section .data
    mensaje:            db "PROGRAMA QUE DETERMINA PROMEDIO", 10,0
    input1:              db "Ingrese nota " ,0
    input2:              db " del estudiante: " ,0
    msgDesaprobado:     db "Desaprobado ", 0 
    msgReprobado:       db "Reprobado ", 0 
    msgAprobado:        db "Aprobado ", 0 
    msgSobresaliente:   db "Sobresaliente ", 0 
    msgError:           db "Error de nota,10,0"
    msgPromedio:        db "Promedio: ",0

section .bss
    promedio resw 1

section .text
    global _start
    
_start:

    PutStr mensaje 

    mov ecx,1    ;Contador notas
    mov ebx,0    ;Recibe notas
    mov eax,0    ;Almacena
    mov edx,0
    LeerNotas:
    PutStr input1
    PutLInt ecx
    PutStr input2
    GetLInt ebx
    add eax , ebx
    inc ecx
    mov ebx,0
    cmp ecx,4
    jl LeerNotas

    ;Determinar Promedio
    dec ecx
    div ecx
    mov [promedio],eax
    ;mov promedio , eax
    PutStr msgPromedio
    PutLInt [promedio]



    ;Determinar Grado
    Reprobado:
    cmp eax,6
        jns Desaprobado
        PutStr msgReprobado
        jmp Fin
    Desaprobado:
    cmp eax,10
        jns Aprobado
        PutStr msgDesaprobado
        jmp Fin

    Aprobado:
    cmp eax,17
        jns Sobresaliente
        PutStr msgAprobado
        jmp Fin
    Sobresaliente:
    cmp eax,20
        jns Error
        PutStr msgSobresaliente
        jmp Fin

    Error:
        PutStr msgError
        jmp Fin

    Fin:
        nwln
        mov eax,1
        int 80h










