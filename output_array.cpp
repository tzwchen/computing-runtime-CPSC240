
//Program name: "Circles". The purpose of this program is to calculate the area of a circle based on user input radius.
//Copyright (C) 2026 Tristan chen *
// *
//This file is part of the software program "Circles". *
//"Circles" is free software: you can redistribute it and/or modify it under the terms of the GNU General
//Public *
//License version 3 as published by the Free Software Foundation. *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
//implied *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
//for more details. *
//A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here: *
//<https://www.gnu.org/licenses/>. The copyright holder may be contacted here: tchen2006@csu.fullerton.edu *
///

//
//Author information
//  Author name: Tristan Chen
//  Author email: tchen2006@csu.fullerton.edu
//
//Program information
//  Program name: Circles
//  Programming languages: C++ and X86 Assembly and BASH
//  Date program began: 2026-Jan-26
//  Date of last update: 2026-Feb-06
//  Date comments upgraded: 2026-Feb-05
//  Date open source license added: 2026-Feb-04
//  Files in this program: main.cpp, circle.asm, isfloat.asm, r.sh
//  Status: Finished.
//  Future upgrade possible: None that are currently envisioned.
//
// Overarching Purpose:
//  Overarching Purpose: The purpose of this program is to calculate the area of a circle based on user input radius. The main module is written in C++ and 
// will call the circle function (implemented in circle.asm) to get the area of the circle, 
// then it will print the area to standard output. The circle function will call the isfloat function (implemented in isfloat.asm) to 
// get a valid float radius from the user, then it will calculate the area of the circle using the formula area = pi * r^2.
//  
// Purpose of this module: The purpose of this module, output_array.cpp is to output floats with 8 digits on the right side of the point including trailing zeroes
//
// This file
//  File name: main.cpp
//  Language: C++
//  Max page width: 132 columns  [132 column width may not be strictly adhered to.]
//  Compile this file: g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17
//     [As the time of upgrade to this program C++ standard 2020 was not available.]
//  Link this program: g++ -m64 -o circles.out main.o circle.o isfloat.o -fno-pie -no-pie -std=c++17
#include <cstddef>
#include <iostream>
#include <iomanip>


extern "C" void output_array(double* arr, long size);

void output_array(double* arr, long size) {
    if (size <= 0 || arr == nullptr) {
        return;
    }

    std::cout << std::fixed << std::setprecision(8);

    for (long i = 0; i < size; ++i) {
        std::cout << arr[i] << std::endl;
    }
}


