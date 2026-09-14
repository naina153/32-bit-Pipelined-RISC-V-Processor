`timescale 1ns/1ps

module immediate_generator_tb;

    logic [31:0] instruction;
    logic [2:0]  imm_type;
    logic [31:0] immediate;

    immediate_generator uut (
        .instruction(instruction),
        .imm_type(imm_type),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        // -----------------------------
        // I-TYPE TEST
        // -----------------------------

        instruction = 32'h00500093;
        imm_type = 3'b000;

        #10;

        $display("I-TYPE IMMEDIATE = %h", immediate);


        // -----------------------------
        // S-TYPE TEST
        // -----------------------------

        instruction = 32'h00502023;
        imm_type = 3'b001;

        #10;

        $display("S-TYPE IMMEDIATE = %h", immediate);


        // -----------------------------
        // B-TYPE TEST
        // -----------------------------

        instruction = 32'h00208863;
        imm_type = 3'b010;

        #10;

        $display("B-TYPE IMMEDIATE = %h", immediate);


        // -----------------------------
        // U-TYPE TEST
        // -----------------------------

        instruction = 32'h123450B7;
        imm_type = 3'b011;

        #10;

        $display("U-TYPE IMMEDIATE = %h", immediate);


        // -----------------------------
        // J-TYPE TEST
        // -----------------------------

        instruction = 32'h0000006F;
        imm_type = 3'b100;

        #10;

        $display("J-TYPE IMMEDIATE = %h", immediate);


        $display("======================================");
        $display("IMMEDIATE GENERATOR SIMULATION COMPLETE");
        $display("======================================");

        $finish;

    end

endmodule