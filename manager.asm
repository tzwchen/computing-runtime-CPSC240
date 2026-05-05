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

; Updated for Assignment 6: Computing Runtime
; Purpose: Benchmark array processing by measuring clock tics and frequency.

extern printf
extern getchar
extern input_array
extern maximum
extern reverse
extern output_array
extern getfreq          ; External function provided by professor

global manager
global array

segment .data
    directions  db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
    directions2 db "After the last input press enter followed by Control+D:", 10, 0
    
    ; Benchmarking Messages
    tics_pre    db "The time on the clock is now %lu tics", 10, 0
    tics_post   db "The time on the clock is now %lu tics", 10, 0
    tics_total  db "The runtime of the sort function was %lu tics", 10, 0
    freq_msg    db "The frequency of the clock of this computer is %0.1lf GHz", 10, 0
    nano_msg    db "The run time of the sort function is %0.2lf nanoseconds", 10, 0
    
    again       db "Do you have another data set to process (Y or N)? ", 0

segment .bss
    array resq 100

segment .text

manager:
    push rbp
    mov rbp, rsp

    lea rdi, [directions]
    xor rax, rax
    call printf
    lea rdi, [directions2]
    xor rax, rax
    call printf

    lea rdi, [array]
    call input_array
    mov r12, rax             ;

    ; --- Benchmarking Start ---
    ; Get initial timestamp
    lfence
    rdtsc                   
    lfence
    shl rdx, 32
    or rax, rdx
    mov r13, rax             

    lea rdi, [tics_pre]
    mov rsi, r13
    xor rax, rax
    call printf

    ; --- Call Functions (Benchmarked Block) ---
    lea rdi, [array]
    mov rsi, r12
    call maximum

    lea rdi, [array]
    mov rsi, r12
    call reverse

    ; --- Benchmarking End ---
    lfence
    rdtsc
    lfence
    shl rdx, 32
    or rax, rdx
    mov r14, rax             

    lea rdi, [tics_post]
    mov rsi, r14
    xor rax, rax
    call printf

    ; Calculate elapsed tics
    mov r15, r14
    sub r15, r13            

    lea rdi, [tics_total]
    mov rsi, r15
    xor rax, rax
    call printf

    ; --- Get Frequency and Calculate Nanoseconds ---
    call getfreq             
    movsd xmm8, xmm0         

    lea rdi, [freq_msg]
    ; xmm0 already contains freq
    mov rax, 1
    call printf

    ; Nanoseconds = tics / frequency
    cvtsi2sd xmm9, r15       ;
    divsd xmm9, xmm8         

    lea rdi, [nano_msg]
    movsd xmm0, xmm9
    mov rax, 1
    call printf

    ; --- Output and Loop ---
    lea rdi, [array]
    mov rsi, r12
    call output_array

    lea rdi, [again]
    xor rax, rax
    call printf
    call getchar
    call getchar
    cmp al, 'Y'
    je manager 

    ; Return nanoseconds to main as requested [cite: 41]
    cvtsd2si rax, xmm9
    pop rbp
    ret