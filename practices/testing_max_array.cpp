#include <cstdint>
#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
#include <thread>

extern "C" {
    char __cdecl max_array(const char*, unsigned n);
}

int main_max_arr()
{
    std::clock_t c_start = std::clock();
    auto t_start = std::chrono::high_resolution_clock::now();
    
    constexpr unsigned t = 2;
    char myword[t*8];
    char  c = 'a';
 //   const char* cc = "abcdabcdfhjdkfshyjzfdshfnaaaa";
    const char* cc = "aaaaaaaabbbbbbbbccccddef";
    for (int i = 0; i < t; i++) {
        
        for (int j = 0; j < 8; j++) {
            myword[i * 8 + j] = c+j;
        }
        c += 1;
    }
    c = max_array(cc, t*8+4+2);

    std::cout << c << " result\n";


    std::clock_t c_end = std::clock();
    auto t_end = std::chrono::high_resolution_clock::now();
    std::cout << std::fixed << std::setprecision(2) << "CPU time used: "
        << 1000.0 * (c_end - c_start) / CLOCKS_PER_SEC << " ms\n"
        << "Wall clock time passed: "
        << std::chrono::duration<double, std::milli>(t_end - t_start).count()
        << " ms\n";
    return 0;
}