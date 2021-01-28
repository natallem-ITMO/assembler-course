extern "C" {
	void __cdecl num_to_string(int);
}
#define NOT_MAIN 3
#ifdef NOT_MAIN 
#define main not_main_str_2
#endif
int main() {
	num_to_string(4);
	return 0; // всегда в vs ставь
}