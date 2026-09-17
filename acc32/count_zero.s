.data
input_addr:      .word 0x80
output_addr:     .word 0x84
n:               .word 0
count:           .word 0
counter:         .word 0
mask1:           .word 1
one:             .word 1
.text
_start:
    load         input_addr
    load_acc
    store        n

    load_imm     0
    store        count

    load_imm     32
    store        counter

loop:
    load         counter
    beqz         done

    load         n
    and          mask1
    bnez         is_one

    load         count
    add          one
    store        count

is_one:
    load         n
    shiftr       one
    store        n

    load         counter
    sub          one
    store        counter

    jmp          loop

done:
    load         count
    store_ind    output_addr
    halt