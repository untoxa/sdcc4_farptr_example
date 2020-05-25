SDCC4 for gbz80 "far pointers" example
--------------------------------------

GBDK-2020 v3.1.1 now supports transparent bank switching when calling __banked functions directly.

Unfortunately it is impossible to call those functions by pointer, because pointers do not
contain information about the banks. I made a library, that allows to contruct "far pointers" 
and call __banked functions indirect with the help of some macros.

Far pointer type and helper macros are defined in far_ptr.h.

	FAR_PTR is a "far pointer" type. low word contains a regular "near pointer", and high 
		word - the "segment" (or bank number).

	TO_FAR_PTR(ofs, seg) macro that constructs a far pointer at compile time

	FAR_SEG(ptr) gets a segment from a far pointer
	FAR_OFS(ptr) gets an offset from a far pointer
	FAR_FUNC(ptr, type) gets an offset from a far pointer and casts it to the given type

	FAR_CALL(ptr, typ, ...) calls the function of a given type indirect by the given far 
		pointer and with provided parameters. banks are switched and restored 
		transparently.

	to_far_ptr(ofs, seg) function that constructs a far pointer at runtime

Usage:

	FAR_PTR farptr_var0 = TO_FAR_PTR(&some_bank1_proc1, sdcc4bank1code_bank);
	res = FAR_CALL(farptr_var1, some_bank1_proc_t, 100, 50);

where some_bank1_proc1 is a __banked function located in sdcc4bank1code_bank, and some_bank1_proc_t 
is a typedef of that function. You may specify the type directly like this:

	FAR_CALL(farptr_var2, void (*)(void));
	
where farptr_var2 is a far pointer to some __banked function without parameters and which is not returning result.


Thanks for reading this readme! Tony.
