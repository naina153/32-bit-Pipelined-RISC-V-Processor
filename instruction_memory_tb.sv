`timescale 1ns/1ps

module instruction_memory_tb;

    logic [31:0] address;
    logic [31:0] instruction;

    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        // =====================================
        // TEST 1: Address 0x00
        // =====================================

        address = 32'h00000000;

        #10;

        $display("------------------------------------");
        $display("TEST 1");
        $display("Address     = %h", address);
        $display("Instruction = %h", instruction);


        // =====================================
        // TEST 2: Address 0x04
        // =====================================

        address = 32'h00000004;

        #10;

        $display("------------------------------------");
        $display("TEST 2");
        $display("Address     = %h", address);
        $display("Instruction = %h", instruction);


        // =====================================
        // TEST 3: Address 0x08
        // =====================================

        address = 32'h00000008;

        #10;

        $display("------------------------------------");
        $display("TEST 3");
        $display("Address     = %h", address);
        $display("Instruction = %h", instruction);


        // =====================================
        // TEST 4: Address 0x0C
        // =====================================

        address = 32'h0000000C;

        #10;

        $display("------------------------------------");
        $display("TEST 4");
        $display("Address     = %h", address);
        $display("Instruction = %h", instruction);


        // =====================================
        // TEST 5: Address 0x10
        // =====================================

        address = 32'h00000010;

        #10;

        $display("------------------------------------");
        $display("TEST 5");
        $display("Address     = %h", address);
        $display("Instruction = %h", instruction);


        // =====================================
        // TEST 6: Address 0x14
        // =====================================

        address = 32'h00000014;

        #10;

        $display("------------------------------------");
        $display("TEST 6");
        $display("Address     = %h", address);
        $display("Instruction = %h", instruction);


        $display("------------------------------------");
        $display("INSTRUCTION MEMORY SIMULATION COMPLETE");
        $display("------------------------------------");

        $finish;

    end

endmodule