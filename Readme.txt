Mohamed Hemdan, 900171923
Ahmed Hassan, 900171850

As of data July 11st 2020 (MS4):

Issues:
1- The processor doesn't have any branch prediction technique for now. It has the static prodictor of not taken
2- It doesn't support the instructions related to control and status registers

Assumptions
1- The data memory stores both instructions and data. The programmer needs to determine that. For our program, we assumed instructions starts at zero and data at 400.

What works from the RV32I?
All the 40 instructions are now supported except the CSRR instructions. 
The processor now is fetching instructions every clock cycle.

What doesn't work?
After we tested our processor on the FPGA for test 2, we tried the same with test 1, but there was a problem that the pc was incrementing continously without any branching which was not the case with this test although it worked perfectly on the simulation. As we didn't have much time to discover what happened on the FPGA level, we depended on the simulation results
We started working on the ID_branching bonus. We finished the code. However, we didn't have time to test it within out processor implementation. We included it as a unfinished task in the Sources folder for reference