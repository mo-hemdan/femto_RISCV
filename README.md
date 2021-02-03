# Femto RISCV Processor
This is an implementation of a small RISCV processor that supports the whole 40 instructions of the RISCV ISA. The processor is implemented in Verilog and tested on a real FPGA using Vivado. Pictures of the test is inlcluded in the reports. 
To be noted, the processor doesn't support instructions relator to control registers

Assumptions
1- The data memory stores both instructions and data. The programmer needs to determine that. For our program, we assumed instructions starts at zero and data at 400.

What works from the RV32I?
All the 40 instructions are now supported except the CSRR instructions. 
The processor now is fetching instructions every clock cycle.

What doesn't work?
We started working on the ID_branching bonus. We finished the code. However, we didn't have time to test it within out processor implementation. We included it as a unfinished task in the Sources folder for reference

This project is done by Mohamed Hemdan and Ahmed Osama
