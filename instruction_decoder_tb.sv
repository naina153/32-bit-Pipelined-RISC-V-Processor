`timescale 1ns/1ps

module instruction_decoder_tb;

    logic [31:0] instruction;

    logic [6:0] opcode;
    logic [4:0] rd;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [2:0] funct3;
    logic [6:0] funct7;

    instruction_decoder uut (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .funct7(funct7)
    );

    initial begin

        $dumpfile("instruction_decoder.vcd");
        $dumpvars(0, instruction_decoder_tb);

        // =====================================
        // TEST 1: ADD x5, x1, x2
        // =====================================

        instruction = 32'h002082B3;

        #10;

        $display("------------------------------------");
        $display("TEST 1: ADD x5, x1, x2");
        $display("Instruction = %h", instruction);
        $display("Opcode      = %b", opcode);
        $display("rd          = %d", rd);
        $display("rs1         = %d", rs1);
        $display("rs2         = %d", rs2);
        $display("funct3      = %b", funct3);
        $display("funct7      = %b", funct7);


        // =====================================
        // TEST 2: SUB x6, x3, x4
        // =====================================

        instruction = 32'h40418333;

        #10;

        $display("------------------------------------");
        $display("TEST 2: SUB x6, x3, x4");
        $display("Instruction = %h", instruction);
        $display("Opcode      = %b", opcode);
        $display("rd          = %d", rd);
        $display("rs1         = %d", rs1);
        $display("rs2         = %d", rs2);
        $display("funct3      = %b", funct3);
        $display("funct7      = %b", funct7);


        // =====================================
        // TEST 3: ADDI x5, x1, 10
        // =====================================

        instruction = 32'h00A08293;

        #10;

        $display("------------------------------------");
        $display("TEST 3: ADDI x5, x1, 10");
        $display("Instruction = %h", instruction);
        $display("Opcode      = %b", opcode);
        $display("rd          = %d", rd);
        $display("rs1         = %d", rs1);
        $display("rs2         = %d", rs2);
        $display("funct3      = %b", funct3);
        $display("funct7      = %b", funct7);


        // =====================================
        // TEST 4: LW x5, 0(x1)
        // =====================================

        instruction = 32'h0000A283;

        #10;

        $display("------------------------------------");
        $display("TEST 4: LW x5, 0(x1)");
        $display("Instruction = %h", instruction);
        $display("Opcode      = %b", opcode);
        $display("rd          = %d", rd);
        $display("rs1         = %d", rs1);
        $display("rs2         = %d", rs2);
        $display("funct3      = %b", funct3);
        $display("funct7      = %b", funct7);


        // =====================================
        // TEST 5: SW x5, 4(x1)
        // =====================================

        instruction = 32'h0050A223;

        #10;

        $display("------------------------------------");
        $display("TEST 5: SW x5, 4(x1)");
        $display("Instruction = %h", instruction);
        $display("Opcode      = %b", opcode);
        $display("rd          = %d", rd);
        $display("rs1         = %d", rs1);
        $display("rs2         = %d", rs2);
        $display("funct3      = %b", funct3);
        $display("funct7      = %b", funct7);


        $display("------------------------------------");
        $display("INSTRUCTION DECODER SIMULATION COMPLETE");
        $display("------------------------------------");

        $finish;

    end

endmodule