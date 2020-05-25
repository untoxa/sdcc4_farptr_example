#ifndef __BANK1_CODE_INCLUDE
#define __BANK1_CODE_INCLUDE

#define sdcc4bank1code_bank 1

typedef int (*some_bank1_proc_t)(int, int) __banked;

extern void some_bank1_proc0() __banked;
extern int some_bank1_proc1(int param1, int param2) __banked;
 
 
#endif