# RISC-IV Instruction Sheet

## 1. Data Movement Instructions

| Instruction | Meaning | Formal Definition | What I Can Say to My Teacher |
|---|---|---|---|
| `lui rd, k` | Load Upper Immediate | `rd <- (k & 0xFFFFF) << 12` | It puts an immediate value into the upper 20 bits of the destination register and fills the lower 12 bits with zeros. |
| `mv rd, rs` | Move | `rd <- rs` | It copies the value from the source register to the destination register. |
| `lw rd, offset(rs1)` | Load Word | `rd <- M[rs1 + offset]` | It calculates a memory address by adding the offset to the base register, then loads a 4-byte word from memory into the destination register. |
| `lb rd, offset(rs1)` | Load Byte | `rd <- signext(M[rs1 + offset][7:0])` | It loads one byte from memory and sign-extends it to fill the destination register. |
| `sw rs2, offset(rs1)` | Store Word | `M[rs1 + offset] <- rs2` | It calculates the memory address using the base register and offset, then stores a 4-byte word from the source register into memory. |
| `sb rs2, offset(rs1)` | Store Byte | `M[rs1 + offset] <- rs2 & 0xFF` | It stores only the lowest 8 bits of the source register as one byte in memory. |

## 2. Arithmetic Instructions

| Instruction | Meaning | Formal Definition | What I Can Say to My Teacher |
|---|---|---|---|
| `addi rd, rs1, k` | Add Immediate | `rd <- rs1 + signext(k)` | It adds a signed constant to the value in a register and saves the result in the destination register. |
| `slti rd, rs1, k` | Set Less Than Immediate | `rd <- (rs1 < signext(k)) ? 1 : 0` | It compares a register value with a signed constant. The destination becomes 1 if the register value is smaller; otherwise, it becomes 0. |
| `add rd, rs1, rs2` | Add | `rd <- rs1 + rs2` | It adds the values in two source registers and stores the result in the destination register. |
| `sub rd, rs1, rs2` | Subtract | `rd <- rs1 - rs2` | It subtracts the value of the second source register from the first and stores the result. |
| `mul rd, rs1, rs2` | Multiply | `rd <- rs1 * rs2` | It multiplies the values in two source registers and stores the low 32 bits of the result. |
| `mulh rd, rs1, rs2` | Multiply High | `rd <- high32(rs1 * rs2)` | It multiplies two signed register values and stores the upper 32 bits of the 64-bit product. |
| `div rd, rs1, rs2` | Divide | `rd <- rs1 / rs2` | It divides the first register value by the second and stores the quotient, rounded toward zero. |
| `rem rd, rs1, rs2` | Remainder | `rd <- rs1 % rs2` | It divides the first register value by the second and stores the remainder. |

## 3. Shift Instructions

| Instruction | Meaning | Formal Definition | What I Can Say to My Teacher |
|---|---|---|---|
| `slli rd, rs1, k` | Shift Left Logical Immediate | `rd <- rs1 << k` | It shifts the bits of a register to the left by a constant number of positions, filling the new low bits with zeros. |
| `srli rd, rs1, k` | Shift Right Logical Immediate | `rd <- logical_right_shift(rs1, k)` | It shifts the bits to the right by a constant number of positions and fills the new high bits with zeros. |
| `srai rd, rs1, k` | Shift Right Arithmetic Immediate | `rd <- arithmetic_right_shift(rs1, k)` | It shifts the bits to the right while preserving the sign bit. |
| `sll rd, rs1, rs2` | Shift Left Logical | `rd <- rs1 << (rs2 & 0x1F)` | It shifts the first register's bits left by the number of positions specified by the low five bits of the second register. |
| `srl rd, rs1, rs2` | Shift Right Logical | `rd <- logical_right_shift(rs1, rs2 & 0x1F)` | It shifts the first register's bits right and fills the high bits with zeros. The shift amount comes from the second register. |
| `sra rd, rs1, rs2` | Shift Right Arithmetic | `rd <- arithmetic_right_shift(rs1, rs2 & 0x1F)` | It shifts the first register's bits right while preserving the sign bit. The shift amount comes from the second register. |

## 4. Bitwise Instructions

| Instruction | Meaning | Formal Definition | What I Can Say to My Teacher |
|---|---|---|---|
| `and rd, rs1, rs2` | Bitwise AND | `rd <- rs1 & rs2` | It performs AND on each pair of corresponding bits. A result bit is 1 only when both input bits are 1. |
| `andi rd, rs1, k` | Bitwise AND Immediate | `rd <- rs1 & signext(k)` | It performs bitwise AND between a register value and an immediate constant. |
| `or rd, rs1, rs2` | Bitwise OR | `rd <- rs1 \| rs2` | It performs OR on corresponding bits. A result bit is 1 if at least one input bit is 1. |
| `ori rd, rs1, k` | Bitwise OR Immediate | `rd <- rs1 \| signext(k)` | It performs bitwise OR between a register value and an immediate constant. |
| `xor rd, rs1, rs2` | Bitwise XOR | `rd <- rs1 ^ rs2` | It performs XOR on corresponding bits. A result bit is 1 when the input bits are different. |
| `xori rd, rs1, k` | Bitwise XOR Immediate | `rd <- rs1 ^ signext(k)` | It performs bitwise XOR between a register value and an immediate constant. |

## 5. Jump and Branch Instructions

| Instruction | Meaning | Formal Definition | What I Can Say to My Teacher |
|---|---|---|---|
| `j address` | Jump | `pc <- address` | It unconditionally jumps to the target address by changing the program counter. |
| `jal rd, address` | Jump and Link | `rd <- pc + 4; pc <- address` | It saves the return address in the destination register and then jumps to the target address. |
| `jalr rd, rs1, k` | Jump and Link Register | `rd <- pc + 4; pc <- rs1 + k` | It saves the return address and jumps to the address calculated by adding an immediate offset to a register. |
| `beqz rs1, address` | Branch if Equal to Zero | `if rs1 == 0: pc <- address` | It jumps to the target address only if the source register contains zero. |
| `bnez rs1, address` | Branch if Not Equal to Zero | `if rs1 != 0: pc <- address` | It jumps to the target address only if the source register is not zero. |
| `beq rs1, rs2, address` | Branch if Equal | `if rs1 == rs2: pc <- address` | It compares two registers and jumps if their values are equal. |
| `bne rs1, rs2, address` | Branch if Not Equal | `if rs1 != rs2: pc <- address` | It compares two registers and jumps if their values are different. |
| `blt rs1, rs2, address` | Branch if Less Than (signed) | `if signed(rs1) < signed(rs2): pc <- address` | It treats both values as signed integers and jumps if the first is smaller than the second. |
| `bge rs1, rs2, address` | Branch if Greater Than or Equal (signed) | `if signed(rs1) >= signed(rs2): pc <- address` | It treats both values as signed integers and jumps if the first is greater than or equal to the second. |
| `bltu rs1, rs2, address` | Branch if Less Than (unsigned) | `if unsigned(rs1) < unsigned(rs2): pc <- address` | It treats both values as unsigned integers and jumps if the first is smaller than the second. |
| `bgeu rs1, rs2, address` | Branch if Greater Than or Equal (unsigned) | `if unsigned(rs1) >= unsigned(rs2): pc <- address` | It treats both values as unsigned integers and jumps if the first is greater than or equal to the second. |

## 6. Program Control

| Instruction | Meaning | Formal Definition | What I Can Say to My Teacher |
|---|---|---|---|
| `halt` | Halt | Stop execution | It stops execution of the program. |

## 7. Important Concepts

| Term | Definition I Can Say |
|---|---|
| Register | A small, fast storage location inside the CPU. |
| Destination register (`rd`) | The register where the result of an instruction is written. |
| Source register (`rs`, `rs1`, `rs2`) | A register that provides input data to an instruction. |
| Immediate | A constant value written directly in the instruction. |
| Memory | The place where the program stores data and instructions. |
| Memory address | A location in memory where data can be read or written. |
| Offset | A value added to a base register to calculate a memory address. |
| Program counter (`pc`) | A register that holds the address used to identify the current or next instruction. |
| Branch | A conditional jump that occurs only when a specified condition is true. |
| Jump | An unconditional change in the program's execution location. |
| Sign extension | Extending a signed value to a wider size by copying its sign bit into the new upper bits. |
| Logical shift | Moving bits and filling the newly opened positions with zeros. |
| Arithmetic right shift | Moving bits right while preserving the sign bit. |
| Bitwise operation | An operation that works on individual bits. |
| Return address | The address to which a function should return after it finishes. |

## 8. How to Explain an Instruction During a Defense

Use this simple structure:

1. **Purpose:** What does the instruction do?
2. **Inputs:** Which registers or constants does it use?
3. **Result:** Where is the result stored, or how does execution change?

Example:

"The `add` instruction adds the values from two source registers and stores the result in the destination register."

Example:

"The `lw` instruction calculates a memory address using a base register and an offset, then loads a word from that address into a destination register."

Example:

"The `beq` instruction compares two registers. If their values are equal, the program jumps to the specified target address. Otherwise, execution continues with the next instruction."