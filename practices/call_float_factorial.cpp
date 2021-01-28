extern "C" {
	float __cdecl float_factorial(int);
	void __cdecl float_factorial_print(int);
}

#include <iostream>
int main_float_fact() {
	int i = 5;
	float result = float_factorial(i);
	std::cout << "Calculated factorial=" << result << "\n";
	std::cout << "And print result in .asm\n";
	float_factorial_print(i);
	return 0; // всегда в vs ставь
}