;*************************************************************************************************
;
;	This program calculates the CPU frequency by recording timestamps before and after a set
;	delay in nanoseconds
;
;  Copyright (C) 2026  Gerardo D. Saucedo
;
;   This program is free software: you can redistribute it and/or modify
;  it under the terms of the GNU General Public License as published by
;  the Free Software Foundation, either version 3 of the License, or
;  (at your option) any later version.
;   This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program.  If not, see <https:;www.gnu.org/licenses/>.
;	
;*************************************************************************************************
;
;	Author Information
;	Name: Gerardo D. Saucedo
;	Email: gerryd@csu.fullerton.edu
;
;	Function Information
;	Name: Get Frequency
;	Languages: x86_64
;
;	Development Information
;	CPU: Intel i7-12700F
;	OS: Arch Linux
;	Tools: NASM, GCC, DDD, Sublime Text
;		
;	Testing Status: Testing Complete
;
;	Description:
;	This program calculates the CPU frequency by recording timestamps before and after a set
;	delay in nanoseconds
;		
;*************************************************************************************************


; External functions
global getfreq


; Declare constants


; segment .data is where initialized data is declared
segment .data

hz2ghz dq 1000000000						;conversion factor from Hz to GHz
cnvsec dq 0.125
delay:										;1/8 second delay struct for syscall 35
	dq 0									;# of seconds
	dq 125000000							;# of nanoseconds


; segment .bss is where uninitialized data is declared
segment .bss


; segment .text is the code
segment .text

getfreq:

; block to backup registers onto stack
push rbp
mov rbp,rsp
push rcx
push rdx
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
sub rsp,8
movsd [rsp],xmm8
sub rsp,8
movsd [rsp],xmm9
sub rsp,8
movsd [rsp],xmm10
pushf
; end block to backup registers onto stack

; block to get initial timestamp
lfence
rdtsc
lfence
shl rdx,32
or rax,rdx
mov r15,rax									;copy rax to r15(initial timestamp)
; end block to get initial timestamp

; block to execute a 1/8 second delay
mov rax,35
lea rdi,[abs delay]
mov rsi,0
syscall
; end block to execute a 1/8 second delay

; block to get post timestamp
lfence
rdtsc
lfence
shl rdx,32
or rax,rdx
mov r14,rax									;copy rax to r14(post timestamp)
; end block to get post timestamp

; block to calulate frequency
sub r14,r15
cvtsi2sd xmm8,r14
movsd xmm9,[abs cnvsec]
divsd xmm8,xmm9
cvtsi2sd xmm10,[abs hz2ghz]
divsd xmm8,xmm10
; end block to calculate frequency


; block to restore registers from stack
movsd xmm0,xmm8

popf
movsd xmm10,[rsp]
add rsp,8
movsd xmm9,[rsp]
add rsp,8
movsd xmm8,[rsp]
add rsp,8
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdx
pop rcx
pop rbp
; end block to restore registers from stack

ret