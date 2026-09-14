`timescale 1ns/1ps

module program_counter_tb;

    logic clk;
    logic reset;
    logic enable;

    logic [31:0] next_pc;
    logic [31:0] pc;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        clk = 0;
        reset = 1;
        enable = 0;
        next_pc = 32'd0;

        // --------------------------------
        // TEST 1: Reset
        // --------------------------------

        #10;

        reset = 0;

        $display("TEST 1: RESET");
        $display("PC = %0d", pc);


        // --------------------------------
        // TEST 2: PC = 4
        // --------------------------------

        enable = 1;
        next_pc = 32'd4;

        #10;

        $display("TEST 2: NEXT PC = 4");
        $display("PC = %0d", pc);


        // --------------------------------
        // TEST 3: PC = 8
        // --------------------------------

        next_pc = 32'd8;

        #10;

        $display("TEST 3: NEXT PC = 8");
        $display("PC = %0d", pc);


        // --------------------------------
        // TEST 4: PC = 12
        // --------------------------------

        next_pc = 32'd12;

        #10;

        $display("TEST 4: NEXT PC = 12");
        $display("PC = %0d", pc);


        // --------------------------------
        // TEST 5: Disable PC
        // --------------------------------

        enable = 0;
        next_pc = 32'd100;

        #10;

        $display("TEST 5: PC HOLD");
        $display("PC = %0d", pc);


        // --------------------------------
        // TEST 6: Enable again
        // --------------------------------

        enable = 1;
        next_pc = 32'd100;

        #10;

        $display("TEST 6: PC UPDATE");
        $display("PC = %0d", pc);


        $display("====================================");
        $display("PROGRAM COUNTER SIMULATION COMPLETE");
        $display("====================================");

        $finish;

    end

endmodule