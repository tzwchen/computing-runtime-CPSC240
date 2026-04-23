#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" long manager(); // Declare the assembly function

int main() {
    cout << "Welcome to Arrays of floating point numbers." << endl;
    cout << "Brought to you by Tristan Chen" << endl;

    long count = manager(); // Call the manager and store the return value

    cout << "The main function received " << count << " and will now keep it." << endl;
    cout << "A zero will be returned to the operating system. Bye." << endl;

    return 0;
}