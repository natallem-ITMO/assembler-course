#include <stdio.h>

void main321() {
	float x = 4.3234f;
	printf("fds");
    printf2("hello %f", x);
	// text, data, rdata, bstext
	//либо через запятую перечислять колды байтиков, либо в кавычках, db
}

int printf2(char const* const _Format, ...)
{
    int _Result;
    va_list _ArgList;
    __crt_va_start(_ArgList, _Format);
    _Result = _vfprintf_l(stdout, _Format, NULL, _ArgList);
    __crt_va_end(_ArgList);
    return _Result;
}