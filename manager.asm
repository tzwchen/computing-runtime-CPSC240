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
;Purpose of this file: The purpose of this module, manager.asm is to manage the flow of the program by calling the other modules in the correct order and passing necessary arguments.
;
;This file
;  File name: manager.asm
;  Language: X86 with Intel syntax.
;  Max page width: 80 columns
;  Compile: nasm -f elf64 -l maximum.lis -o maxmmum.o maximum.asm
;  Link: gcc -no-pie -o circles main.cpp circle.o isfloat.o


;Begin code

extern printf
extern getchar
extern input_array
extern maximum
extern reverse
extern output_array
global manager
global array

;declarations
segment .bss
    size resq 1 ; reserve space for the size of the array
    array resq 100
segment .data
    recieved_input db "These numbers were recieved and place into an array", 0
    max_msg db "The maximum value in the array is: ", 0
    reverse_msg db "The array has been reversed. The array is now the following: ", 0
    again db "Do you hvae another data set to process (Y or N)? ", 0
    directions db "For the array enter a sequence of 64-bit floats seperated by white space.", 0
    directions2 db "After the last input press enter followed by Control+D:", 0

segment .text

manager: ;this is a loop btw
    push rbp
    mov rbp, rsp

    ;print directions
    lea rdi, [directions]
    xor rax, rax
    call printf
    lea rdi, [directions2]
    xor rax, rax
    call printf

    ;call input array 
    lea rdi, [array] ;pass array address
    call input_array
    mov r12, rax ;save the number of elements returned

    ;call maximum to find the maximum value in the array
    lea rdi, [array]
    mov rsi, r12
    call maximum

    ;call reverse to reverse the order of the elements in the array
    lea rdi, [array]
    mov rsi, r12
    call reverse

    ;call output_array to display the array
    lea rdi, [reverse_msg]
    xor rax, rax
    call printf
    lea rdi, [array]
    mov rsi, r12
    call output_array

    ;ask user if they want to process another data set
    lea rdi, [again]
    xor rax, rax
    call printf
    call getchar
    call getchar
    cmp al, 'Y'
    je manager ;repeat if user wants to do it again

    mov rax, r12 ;returns sie to main.cpp
    pop rbp
    ret
