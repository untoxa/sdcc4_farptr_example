#include "far_ptr.h"

void * __call_banked_addr;
unsigned char __call_banked_bank;

void __call__banked() __naked {
__asm
            ldh     A, (#__current_bank)
            push    AF
            ld      HL, #caba01$
            push    HL
            ld      HL, #___call_banked_addr
            ld      A, (HL+)
            ld      H, (HL)
            ld      L, A
            ld      A, (#___call_banked_bank)
            ld      (#0x2000),A
            ldh     (#__current_bank), A
            jp      (HL)
caba01$:
            pop     AF
            ld      (#0x2000), A
            ldh     (#__current_bank), A
            ret
__endasm;        
}

long to_far_ptr(void* ofs, int seg) __naked {
    ofs; seg;
__asm
            lda     HL, 2(SP)
            ld      A, (HL+)
            ld      E, A
            ld      A, (HL+)
            ld      D, A
            ld      A, (HL+)
            ld      H, (HL)
            ld      L, A
            ret
__endasm;    
}
