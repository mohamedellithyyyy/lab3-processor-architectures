## Acc32 Sheet

### Instructions

| Instruction | Meaning | Definition |
|----|---|---|
| `load_imm X` | `Acc ← X` | Put the **value `X` directly** into the accumulator. |
| `load X` | `Acc ← Mem[PC + X]` | Load a value from a **relative memory address** into `Acc`. |
| `store X` | `Mem[PC + X] ← Acc` | Store `Acc` into a **relative memory address**. |
| `load_addr X` | `Acc ← Mem[X]` | Load a value from the **absolute address `X`** into `Acc`. |
| `store_addr X` | `Mem[X] ← Acc` | Store `Acc` into the **absolute address `X`**. |
| `load_acc` | `Acc ← Mem[Acc]` | Use the current `Acc` value as a memory address, then load the value from that address. |
| `store_ind X` | `Mem[Mem[X]] ← Acc` | Use `Mem[X]` as the destination address, then store `Acc` there. |
| `add X` | `Acc ← Acc + Mem[X]` | Add the value at memory address `X` to `Acc`. Updates `C` and `V`. |
| `sub X` | `Acc ← Acc - Mem[X]` | Subtract the value at memory address `X` from `Acc`. Updates `C` and `V`. |
| `mul X` | `Acc ← Acc × Mem[X]` | Multiply `Acc` by the value at memory address `X`. Updates `C` and `V`. |
| `div X` | `Acc ← Acc / Mem[X]` | Divide `Acc` by the value at memory address `X`. |
| `rem X` | `Acc ← Acc % Mem[X]` | Calculate the remainder of `Acc / Mem[X]` and put it into `Acc`. |
| `shiftl X` | `Acc ← Acc << Mem[X]` | Shift the bits of `Acc` to the **left**. |
| `shiftr X` | `Acc ← Acc >> Mem[X]` | Shift the bits of `Acc` to the **right**, preserving the sign. |
| `and X` | `Acc ← Acc & Mem[X]` | Perform a bitwise AND between `Acc` and `Mem[X]`. |
| `or X` | `Acc ← Acc \| Mem[X]` | Perform a bitwise OR between `Acc` and `Mem[X]`. |
| `xor X` | `Acc ← Acc ^ Mem[X]` | Perform a bitwise XOR between `Acc` and `Mem[X]`. |
| `not` | `Acc ← ~Acc` | Invert every bit of `Acc`. |
| `clv` | `V ← 0` | Clear the **Overflow** flag. |
| `clc` | `C ← 0` | Clear the **Carry** flag. |
| `jmp X` | `PC ← X` | Unconditionally jump to address `X`. |
| `beqz X` | `if Acc == 0 → PC ← X` | Jump to `X` if `Acc` is zero. |
| `bnez X` | `if Acc != 0 → PC ← X` | Jump to `X` if `Acc` is not zero. |
| `bgtz X` | `if Acc > 0 → PC ← X` | Jump to `X` if `Acc` is greater than zero. |
| `bgez X` | `if Acc >= 0 → PC ← X` | Jump to `X` if `Acc` is greater than or equal to zero. |
| `bltz X` | `if Acc < 0 → PC ← X` | Jump to `X` if `Acc` is less than zero. |
| `bvs X` | `if V == 1 → PC ← X` | Jump to `X` if the Overflow flag is set. |
| `bvc X` | `if V == 0 → PC ← X` | Jump to `X` if the Overflow flag is clear. |
| `bcs X` | `if C == 1 → PC ← X` | Jump to `X` if the Carry flag is set. |
| `bcc X` | `if C == 0 → PC ← X` | Jump to `X` if the Carry flag is clear. |
| `halt` | `STOP` | Stop execution of the program. |

---

## Symbols / Notation

| Symbol | Definition |
|---|---|
| `Acc` | **Accumulator** — the main 32-bit register. |
| `Mem[X]` | The value stored at memory address `X`. |
| `PC` | **Program Counter** — holds the address used for program execution. |
| `C` | **Carry flag** — indicates a carry condition from arithmetic. |
| `V` | **Overflow flag** — indicates signed arithmetic overflow. |
| `←` | "Gets", "is assigned", or "becomes". |
| `+` | Addition. |
| `-` | Subtraction. |
| `×` | Multiplication. |
| `/` | Division. |
| `%` | Remainder / modulo. |
| `&` | Bitwise AND. |
| `\|` | Bitwise OR. |
| `^` | Bitwise XOR. |
| `~` | Bitwise NOT / invert all bits. |
| `<<` | Shift bits to the left. |
| `>>` | Shift bits to the right. |
| `==` | Equal to. |
| `!=` | Not equal to. |
| `>` | Greater than. |
| `>=` | Greater than or equal to. |
| `<` | Less than. |
| `→` | "If this condition is true, then..." |

---

## Addressing Notation

This part is especially important when reading Acc32 code:

| Notation | Meaning |
|---|---|
| `X` | The value/address represented by `X`. |
| `Mem[X]` | Read the value stored at address `X`. |
| `Mem[Mem[X]]` | Read `Mem[X]`, treat that result as an address, then access that address. |
| `PC + X` | A memory address relative to the Program Counter. |
| `Acc` | The current value inside the accumulator. |