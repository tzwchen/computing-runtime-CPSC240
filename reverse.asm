;****************************************************************************************************************************
;Program name: "Circles". The purpose of this program is to calculate the area of a circle based on user input radius.
;Copyright (C) 2026 Tristan chen *
; *
;This file is part of the software program "Circles". *
;"Circles" is free software: you can redistribute it and/or modify it under the terms of the GNU General
;Public *
;License version 3 as published by the Free Software Foundation. *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
;implied *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
;for more details. *
;A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here: *
;<https://www.gnu.org/licenses/>. The copyright holder may be contacted here: tchen2006@csu.fullerton.edu *
;*************************************************************************************************************************/

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Tristan Chen
;  Author email: tchen2006@csu.fullerton.edu
;
;Program information
;  Program name: Arrays
;  Programming languages: main module and output array in C++, input_array, isfloat, manager, maximum, and reverse modules in x86 assembly language with Intel syntax, shell scripts written in BASH
;  Date of last update: 2026-Mar-8
;  Date comments upgraded: 2026-Mar-8
;  Date open source license added: 2026-Mar-8
;  Files in this program: input_array.asm, isfloat.asm, manager.asm, maximum.asm, reverse.asm, output_array.cpp main.cpp, r.sh
;  Status: Finished.
;  Future upgrade possible: None that are currently envisioned.
;

;
;Purpose of this file: The purpose of this module, reverse.asm is to reverse the order of the elements in the array
;
;This file
;  File name: reverse.asm
;  Language: X86 with Intel syntax.
;  Max page width: 80 columns
;  Compile: nasm -f elf64 -l maximum.lis -o maxmmum.o maximum.asm
;  Link: gcc -no-pie -o circles main.cpp circle.o isfloat.o

;begin code
extern array
extern isfloat
global reverse

;declaratoions
segment .bss
    i resq 1 ;loop index
    size resq 1 ;size of array

segment .text
reverse:
    push rbp
    mov rbp, rsp

    ;rdi = array address, rsi = size
    mov r8, 0 ;Left index
    mov r9, rsi
    dec r9 ;Right index (size - 1)

reverse_loop:
    cmp r8, r9
    jge reverse_done ;Stop when pointers meet or cross

    ;Swap elements at [rdi + r8*8] and [rdi + r9*8]
    movsd xmm0, [rdi + r8*8]
    movsd xmm1, [rdi + r9*8]
    movsd [rdi + r8*8], xmm1
    movsd [rdi + r9*8], xmm0

    inc r8
    dec r9
    jmp reverse_loop

reverse_done:
    pop rbp
    ret
