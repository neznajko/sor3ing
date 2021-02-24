//        1         2         3         4         5         6
//23456789012345678901234567890123456789012345678901234567890123 
        .att_syntax noprefix
        .global main
////////========........````````,,,,,,,,^^^^^^^^        ::::::::
        .data
        .equ ONE,   0x31202020 /* "   1" */
        .equ TWO,   0x32202020 /* "   2" */
        .equ THREE, 0x33202020 /* "   3" */
a:      .asciz "   3   3   2   1   2   3   2   2   1"
z:      .equ SIZE, (z-a)/4
fmt1:   .string "%s (%d,%d)\n"
fmt2:   .string "Total exchanges: %d\n"
////////________,,,,,,,,````````--------        >>>>>>>>********
        .text
.macro  pushq
        push    rax
        push    rbx
        push    rcx
        push    rdx
        push    rsi
        push    rdi
        push    r8
        push    r9
        push    r10
        push    r11
        push    r12
        push    r13
        push    r14
        push    r15
.endm
.macro  popq
        pop     r15
        pop     r14
        pop     r13
        pop     r12
        pop     r11
        pop     r10
        pop     r9
        pop     r8
        pop     rdi
        pop     rsi
        pop     rdx
        pop     rcx
        pop     rbx
        pop     rax
.endm
//        1         2         3         4         5         6
//23456789012345678901234567890123456789012345678901234567890123 
// infut: rbp(a), r11(i), r12(j)
// descr: exchanges a[i] and a[j]
// modif: rcx(n)
xchg:   nop
        // dunf
        pushq              /* backup */
        lea fmt1(rip), rdi /* 1st */
        mov rbp, rsi       /* 2nd */
        mov r11, rdx       /* 3rd */
        mov r12, rcx       /* 4th */
        xor rax, rax       /* varargs */
        call printf        /* yeah! */
        popq               /* re-establish */
        // xchg
        mov (rbp,r11,4), eax  /* eax  <-  a[i] */
        xchg eax, (rbp,r12,4) /* a[j] <-> eax  */
        mov eax, (rbp,r11,4)  /* a[i] <-  eax  */
        inc rcx               /* ++n */
        ret
////////========........,,,,,,,,````````        --------::::::::
.macro swap i, j
        mov \i, r11
        mov \j, r12
        call xchg
.endm
////////--------%%%%%%%%========________"""""""",,,,,,,,````````
// infut: rbp(a), r8(p), r15(q)
// oufut: r14(j), -1 if not found
// descr: moving backward in the range (p, q) search for ONE
last:   nop
        mov r15, r14           /* j <- q */ 
0:      dec r14                /* --j */
        cmp r8, r14            /* j == p? */
        jz  2f                 /* yeah! */
        cmpl $ONE, (rbp,r14,4) /* is it? */
        jz 1f                  /* yep */
        jmp 0b                 /* loof */
2:      mov $-1, r14           /* woah! not found */
1:      ret
////////--------________        ********========________::::::::
// infut: rbp(a), r8(p), r15(q)
// oufut: r9(i), -1 if not found
// descr: moving forward in the range (p, q) search for THREE
first:  nop
        lea 1(r8), r9           /* i <- p + 1             */ 
0:      cmp r15, r9             /* i == q?                */
        jz  2f                  /* yep                    */
        cmpl $THREE, (rbp,r9,4) /* is it?                 */
        jz  1f                  /* yeah!                  */
        inc r9                  /* ++i                    */
        jmp 0b                  /* continuer \a re/p/eter */
2:      mov $-1, r9             /* woah! not found        */
1:      ret
/////////********````````,,,,,,,,--------::::::::>>>>>>>>________
// rbp: a - records
// r8:  p - left end position
// r15: q - right end position
// r14: k - last ONE's position
// r9:  m - first THREE's position
// rcx: n - xchg counter
/**/
main:   nop
        xor rax, rax    /* clear */
        xor rcx, rcx    /* n <- 0 */
        lea a(rip), rbp /* relative addressing */
        mov $-1, r8     /* p <- -1 */
        mov $SIZE, r15  /* q <- SIZE */
0:      inc r8          /* ++p */
        dec r15         /* --q */
        cmp r8, r15     /* p < q? */
        jng spit        /* nop */
        /* eat 1's */
1:      cmpl $ONE, (rbp,r8,4) /* a[p] == 1? */
        jnz 3f                /* nop */
        inc r8                /* ++p */
        cmp $SIZE, r8         /* p == SIZE? */
        jz spit               /* yeah, only 1's string */
        jmp 1b                /* continuer à répéter */
        /* eat 3's */
3:      cmpl $THREE, (rbp,r15,4) /* a[q] == 3? */
        jnz 4f                   /* nop */
        dec r15                  /* --q */
        cmp $-1, r15             /* q == -1? */
        jz spit                  /* whoa, only 3's string */
        jmp 3b                   /* continuer \a re/pe/ter */
        /* consider all 4 variants */
4:      cmpl $THREE, (rbp,r8,4) /* a[p] == 3? */
        jnz 2f                  /* nop */
        cmpl $ONE, (rbp,r15,4)  /* a[q] == 1? */
        jz 9f                   /* yeah! */
        // othervize we havv to lokk for last ONE
        call last               /* k <- r14 */
        cmp $-1, r14            /* ck if not -1 */
        jz 9f                   /* skip swap */
        swap r14, r15           /* xchg k, q */
        jmp 9f                  /* xchg p, q */
        // a[p] == 2, case:
2:      cmpl $ONE, (rbp,r15,4)  /* a[q] == 1? */
        jnz 1f                  /* eN:Ou:Pe */
        // here we haaf 2 .. 3 .. 1 variant
        call first              /* m <- r9 */
        cmp $-1, r9             /* ck ck */
        jz 9f                   /* yea */
        swap r8, r9             /* swap a[p], a[m] */
        jmp 9f                  /* bbom */
        // Ok 2 .. 3 .. 1 .. 2 scenario
1:      call first              /* m <- r9 */
        cmp $-1, r9             /* m == -1? */
        jz 3f                   /* yep */
        swap r15, r9            /* a[q] <-> a[m] */
3:      call last               /* k <- r14 */
        cmp $-1, r14            /* k == -1? */
        jz 1f                   /* yep */
        swap r8, r14            /* a[p] <-> a[k] */
        // ck if k == m == -1
1:      cmp $-1, r14            /* are ve don? */
        jz spit                 /* yep */
        jmp 0b                  /* continue */
9:      swap r8, r15            /* xchg p and q */
        jmp 0b                  /* loof */
spit:   mov rbp, rdi            /* puts argument */
        push rcx                /* backup */
        call puts               /* yea */
        pop rcx                 /* re-establish */
        lea fmt2(rip), rdi      /* 1st */
        mov rcx, rsi            /* 2nd */
        xor rax, rax            /* why the fuk? */
        call printf             /* bbom */
        ret
// log:
