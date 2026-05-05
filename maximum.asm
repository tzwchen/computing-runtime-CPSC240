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
;Purpose of this file: The purpose of this module, maximum.asm is to find the maximum valye present in the array
;
;This file
;  File name: maximum.asm
;  Language: X86 with Intel syntax.
;  Max page width: 80 columns
;  Compile: nasm -f elf64 -l maximum.lis -o maxmmum.o maximum.asm
;  Link: gcc -no-pie -o circles main.cpp circle.o isfloat.o


;Begin code

extern array
extern isfloat;

global maximum;

;declarations
segment .bss 
    max resq 1 ; reserve space for the maximum value
    i resq 1 ; reserve space for the loop index
    size resq 1 ; reserve space for the size of the array

segment .text

maximum:
    push rbp
    mov rbp, rsp

    ;rdi = array pointer, rsi=size
    movsd xmm0, [rdi] ;Assume first element is max
    mov rcx, 1        ;Counter starts at 1

max_loop:
    cmp rcx, rsi
    jge max_done

    movsd xmm1, [rdi + rcx*8]
    ucomisd xmm1, xmm0 ;Compare current to max
    jbe next_item
    movsd xmm0, xmm1   ;Update max

next_item:
    inc rcx
    jmp max_loop

max_done:
    ;Max value is now in xmm0 for the caller
    pop rbp
    ret