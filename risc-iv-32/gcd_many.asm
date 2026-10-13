.text



_start:

    addi    t0, zero, 0x80

    addi    t1, zero, 0x84



    lw      t2, 0(t0)



    ble     t2, zero, invalid



    lw      t3, 0(t0)



    ble     zero, t3, first_ready

    sub     t3, zero, t3



first_ready:

    addi    t2, t2, -1



loop:

    beqz    t2, finish



    lw      t4, 0(t0)



    ble     zero, t4, value_ready

    sub     t4, zero, t4



value_ready:



gcd_loop:

    beqz    t4, gcd_done



    rem     t5, t3, t4

    mv      t3, t4

    mv      t4, t5



    j       gcd_loop



gcd_done:



    addi    t2, t2, -1

    j       loop



invalid:

    addi    t3, zero, -1



finish:

    sw      t3, 0(t1)

    halt