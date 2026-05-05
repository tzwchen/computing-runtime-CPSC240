#!/bin/bash

rm -f arrays.out

echo "Assembling..."

nasm -f elf64 -o getfrequency.o getfrequency.asm

nasm -f elf64 -o input_array.o input_array.asm
nasm -f elf64 -o isfloat.o isfloat.asm
nasm -f elf64 -o manager.o manager.asm
nasm -f elf64 -o maximum.o maximum.asm
nasm -f elf64 -o reverse.o reverse.asm

echo "Compiling C++ modules..."

g++ -c -m64 -Wall -std=c++17 -o main.o main.cpp -fno-pie
g++ -c -m64 -Wall -std=c++17 -o output_array.o output_array.cpp -fno-pie

echo "Linking all object files..."

g++ -m64 -std=c++17 -no-pie -o arrays.out \
    main.o \
    manager.o \
    input_array.o \
    isfloat.o \
    maximum.o \
    reverse.o \
    output_array.o \
    getfrequency.o

chmod +x arrays.out
./arrays.out

rm -f *.o

echo "The script has terminated."