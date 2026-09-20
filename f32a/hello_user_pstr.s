.data

greet_buf:     .byte 95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95,95
q_msg:         .byte 'W','h','a','t',' ','i','s',' ','y','o','u','r',' ','n','a','m','e','?',10
name_count:    .word 0
overflow_flag: .word 0

.text

_start:
    lit q_msg
    a!
    18 >r

print_q_loop:
    @+
    !p 0x84
    next print_q_loop

    lit 0
    if part2
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

part2:
    lit greet_buf
    1 +
    a!

    'H' !+
    'e' !+
    'l' !+
    'l' !+
    'o' !+
    ',' !+
    ' ' !+

    0 !p name_count

read_loop:
    @p 0x80
    dup
    10 xor
    if read_done

    @p name_count
    23 xor
    if too_long

    !+

    @p name_count
    1 +
    !p name_count

    lit 0
    if read_loop

too_long:
    drop
    1 !p overflow_flag
    lit 0
    if read_loop

read_done:
    drop
    @p name_count
    if do_error

    @p overflow_flag
    if build_greeting

do_error:
    lit 0xCCCCCCCC
    !p 0x84
    halt

build_greeting:
    '!' !+

    @p name_count
    8 +
    dup
    lit greet_buf
    a!
    !+

    -1 +
    >r

    lit greet_buf
    1 +
    a!

send_loop:
    @+
    !p 0x84
    next send_loop

    halt