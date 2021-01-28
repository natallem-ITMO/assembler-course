#include <cstdio>
#include <iostream>
struct haha {
	int a, b, c, d, e;
	//haha(int a): a(a) , b(a+1), c(a+2) { }
	haha returnHaha();
	int get5();
};

haha returnHaha();

int main_struct() {
	haha p = haha().returnHaha();
	std::cout << &p.a << " " << &p.b << " " << &p.c;
	 printf("p struct a=%i, b=%i, c=%i", p.a, p.b, p.c);

	// printf("hello %i", fdf.get5());
	return 0;
}