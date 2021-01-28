#include <cstdint>
#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
#include <thread>

extern "C" {
    char __cdecl str_len(const char*, unsigned n);
}

int main()
{
    std::clock_t c_start = std::clock();
    auto t_start = std::chrono::high_resolution_clock::now();

    char myword[128 * 2];
    char  c = 'a';
    //   const char* cc = "abcdabcdfhjdkfshyjzfdshfnaaaa";
    const char* cc = "aaaaaaaaaaaaaaaa bbbbbbbbbbbbbbbbbbb";
    for (int i = 0; i < 16; i++) {
        myword[i] = 'd';
    }
    char t = 'a';
    for (int i = 16; i < 16 *2 ; i++) {
        myword[i] = t;
        t = t + 1;
    }
   
    myword[16*2 - 1] = '\0';
    c = str_len(myword, 128* 2);

    std::cout << c << " result\n";


    std::clock_t c_end = std::clock();
    auto t_end = std::chrono::high_resolution_clock::now();
    std::cout << std::fixed << std::setprecision(2) << "CPU time used: "
        << 1000.0 * (c_end - c_start) / CLOCKS_PER_SEC << " ms\n"
        << "Wall clock time passed: "
        << std::chrono::duration<double, std::milli>(t_end - t_start).count()
        << " ms\n";
}