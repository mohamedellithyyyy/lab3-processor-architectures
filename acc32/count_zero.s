; count_zero(n): count the number of zero bits in the 32-bit
; representation of n. Input at 0x80, output written to 0x84.
;
; No domain restriction (any 32-bit n is valid) and no overflow
; possible (result is always 0..32), so no -1 / 0xCCCCCCCC paths
; are needed for this variant.

    load_addr 0x80        ; acc <- n (input)
    store_addr n          ; n <- acc

    load_imm 0
    store_addr count       ; count <- 0

    load_imm 32
    store_addr counter     ; counter <- 32

loop:
    load_addr counter
    beqz done              ; while counter != 0

    load_addr n
    and mask1               ; acc <- n & 1
    bnez is_one

    load_addr count
    add one
    store_addr count        ; count++ (bit was 0)

is_one:
    load_addr n
    shiftr one               ; n <- n >> 1
    store_addr n

    load_addr counter
    sub one
    store_addr counter       ; counter--

    jmp loop

done:
    load_addr count
    store_addr 0x84          ; output <- count
    halt

; --- data ---
n:       0
count:   0
counter: 0
mask1:   1
one:     1