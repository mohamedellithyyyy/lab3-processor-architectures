    .text

    .org     0x100                           ; keep code clear of I/O cells 0x80, 0x84



; Global registers: A0 = input port, A1 = output port, A2 = line buffer.



_start:

    movea.l  0x80, A0

    movea.l  0x84, A1

    movea.l  0x400, A2

    movea.l  0x1000, A7                      ; stack grows down



    jsr      read_line                       ; D0 <- length, or -1 if > 63 chars

    cmp.l    -1, D0

    beq      _start_overflow

    jsr      print_reversed

    halt



_start_overflow:

    move.l   0xcccccccc, D0

    move.l   D0, (A1)

    halt



; read_line: input up to '\n' -> buffer as C string.

read_line:

    movea.l  A2, A3

    clr.l    D0

read_line_loop:

    move.b   (A0), D1

    cmp.b    10, D1

    beq      read_line_done

    cmp.l    63, D0                          ; no room for char + '\0'

    beq      read_line_overflow

    move.b   D1, (A3)+

    add.l    1, D0

    jmp      read_line_loop

read_line_done:

    clr.b    (A3)

    rts

read_line_overflow:

    move.l   -1, D0

    rts



; print_reversed: D0 = length. D3 = scan index, D4 = word end, D5 = "first" flag.

print_reversed:

    move.l   D0, D3

    move.l   1, D5

print_reversed_skip:                         ; skip spaces backwards

    cmp.l    0, D3

    beq      print_reversed_done

    move.b   -1(A2,D3), D2

    cmp.b    32, D2

    bne      print_reversed_word

    sub.l    1, D3

    jmp      print_reversed_skip

print_reversed_word:

    move.l   D3, D4

print_reversed_scan:                         ; find word start

    cmp.l    0, D3

    beq      print_reversed_emit

    move.b   -1(A2,D3), D2

    cmp.b    32, D2

    beq      print_reversed_emit

    sub.l    1, D3

    jmp      print_reversed_scan

print_reversed_emit:                         ; word = buf[D3 .. D4)

    cmp.l    0, D5

    bne      print_reversed_nosep

    move.l   32, D0

    jsr      put_char

print_reversed_nosep:

    move.l   0, D5

    jsr      print_word

    jmp      print_reversed_skip

print_reversed_done:

    rts



; print_word: print buf[D3 .. D4); D3 preserved via stack.

print_word:

    move.l   D3, -(A7)

print_word_loop:

    cmp.l    D4, D3

    beq      print_word_done

    move.b   0(A2,D3), D0

    jsr      put_char

    add.l    1, D3

    jmp      print_word_loop

print_word_done:

    move.l   (A7)+, D3

    rts



put_char:

    move.b   D0, (A1)

    rts