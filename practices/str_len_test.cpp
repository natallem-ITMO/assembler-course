#include <cstdint>
#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
#include <thread>

extern "C" {
    int __cdecl str_len(const char*);
}

int main_str_len()
{
    
    const int bigLenStr = 1000000;
    char cc[bigLenStr];
    for (int i = 0; i < bigLenStr; i++) {
        cc[i] = 'a'+(i % 6);
    }
    std::cout << cc[1];

    std::clock_t c_start_my_func = std::clock();
    auto t_start_my = std::chrono::high_resolution_clock::now();
    int res_my = str_len(cc);
    std::clock_t c_end_my_func = std::clock();
    auto t_end_my = std::chrono::high_resolution_clock::now();


    std::clock_t c_start_std = std::clock();
    auto t_start_std = std::chrono::high_resolution_clock::now();
    int res_std = strlen(cc);
    std::clock_t c_end_std = std::clock();
    auto t_end_std = std::chrono::high_resolution_clock::now();


    std::cout << "My result: " << res_my << ".\n" << std::fixed << std::setprecision(2) << "CPU time used: "
        << 1000.0 * (c_end_my_func - c_start_my_func) / CLOCKS_PER_SEC << " ms\n"
        << "Wall clock time passed: "
        << std::chrono::duration<double, std::milli>(t_end_my - t_start_my).count()
        << " ms\n";

    std::cout<<"Std result: "<< res_std<< ".\n" << std::fixed << std::setprecision(2) << "CPU time used: "
        << 1000.0 * (c_end_std - c_start_std) / CLOCKS_PER_SEC << " ms\n"
        << "Wall clock time passed: "
        << std::chrono::duration<double, std::milli>(t_end_std - t_start_std).count()
        << " ms\n";
    return 0;
}