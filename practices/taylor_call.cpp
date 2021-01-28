#include <cstdint>
#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
#include <thread>

extern "C" {
	float __cdecl taylor(float, uint32_t n);
}

//int main_tailor()
int main()
{
    std::clock_t c_start = std::clock();
    auto t_start = std::chrono::high_resolution_clock::now();
   
	float num = 0.5f;
	uint32_t n = 10000000;
	float t = taylor(num, n);
     
    
    std::clock_t c_end = std::clock();
    auto t_end = std::chrono::high_resolution_clock::now();
std::cout << "result (n=" << n << ") = " << t << "\n";
    std::cout << std::fixed << std::setprecision(2) << "CPU time used: "
        << 1000.0 * (c_end - c_start) / CLOCKS_PER_SEC << " ms\n"
        << "Wall clock time passed: "
        << std::chrono::duration<double, std::milli>(t_end - t_start).count()
        << " ms\n";
    return 0;
}

