extern void __cdecl num_to_string(int);
#include <Windows.h>
#define NOT_MAIN 1

#ifdef NOT_MAIN
#define main not_main_1
#endif

int main() {
    num_to_string(90);
    return 0; // всегда тут ставь!
}