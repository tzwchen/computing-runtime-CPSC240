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
;Purpose of this file: The purpose of this module, input_array.asm is to input values into the array
;
;This file
;  File name: input_array.asm
;  Language: X86 with Intel syntax.
;  Max page width: 80 columns
;  Compile: nasm -f elf64 -l maximum.lis -o maxmmum.o maximum.asm
;  Link: gcc -no-pie -o circles main.cpp circle.o isfloat.o


;Begin code
extern array
extern scanf
extern getchar 
extern printf
global input_array


;declarations
section .data
    format_input db "%lf", 0 
    error db "Please re-enter the last number.", 0


section .text

input_array:
    push rbp
    mov rbp, rsp 
    push rbx     
    push r12           

    xor rbx, rbx  ;sets counter to 0

read_loop:
    ;is array at 100 elements yet?
    cmp rbx, 100
    je input_done


    ;prompts user 
    lea rdi, [format_input] 
    lea rsi, [array + rbx*8] 
    xor rax, rax            
    call scanf ;returns items read

    ;ok i know i used eax here, but this is why: scanf returns an int (32 bit), so it fills eax with 0xffff... but its zero extended into rax, which makes it equal to big number instead of -1 so i have to use eax
    cmp eax, -1
    je input_done 

    cmp eax, 1
    je valid_input

    lea rdi, [error]
    xor rax, rax
    call printf
    

clear_buffer: ;need to do this to prevent infinite loops...refer back to circles assignment
    call getchar
    cmp rax, -1
    je input_done
    cmp rax , 10 ;check if newline
    je read_loop ;if end, exit
    jmp clear_buffer

valid_input:
    ;repeat loop til done
    inc rbx
    jmp read_loop 

input_done:
    ;Return the size of the array to the caller
    mov rax, rbx
    pop r12
    pop rbx
    pop rbp
    ret



