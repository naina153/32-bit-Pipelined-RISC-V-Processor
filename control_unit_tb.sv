`timescale 1ns/1ps

module control_unit_tb;

    // =========================================
    // INPUTS
    // =========================================

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    // =========================================
    // OUTPUTS
    // =========================================

    logic       reg_write;
    logic       mem_read;
    logic       mem_write;
    logic       mem_to_reg;

    logic       alu_src;
    logic       branch;
    logic       jump;

    logic [3:0] alu_control;


    // =========================================
    // CONTROL UNIT
    // =========================================

    control_unit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),

        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),

        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),

        .alu_control(alu_control)
    );


    // =========================================
    // TESTS
    // =========================================

    initial begin

        $dumpfile("control_unit.vcd");
        $dumpvars(0, control_unit_tb);


        // =====================================
        // TEST 1: ADD
        // ADD x5, x1, x2
        // opcode = 0110011
        // funct3 = 000
        // funct7 = 0000000
        // =====================================

        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 1: ADD");
        $display("reg_write   = %b", reg_write);
        $display("mem_read    = %b", mem_read);
        $display("mem_write   = %b", mem_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_src     = %b", alu_src);
        $display("branch      = %b", branch);
        $display("jump        = %b", jump);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 2: SUB
        // SUB x5, x1, x2
        // =====================================

        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0100000;

        #10;

        $display("----------------------------------------");
        $display("TEST 2: SUB");
        $display("reg_write   = %b", reg_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 3: AND
        // =====================================

        opcode = 7'b0110011;
        funct3 = 3'b111;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 3: AND");
        $display("reg_write   = %b", reg_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 4: OR
        // =====================================

        opcode = 7'b0110011;
        funct3 = 3'b110;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 4: OR");
        $display("reg_write   = %b", reg_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 5: XOR
        // =====================================

        opcode = 7'b0110011;
        funct3 = 3'b100;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 5: XOR");
        $display("reg_write   = %b", reg_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 6: ADDI
        // =====================================

        opcode = 7'b0010011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 6: ADDI");
        $display("reg_write   = %b", reg_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_src     = %b", alu_src);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 7: LW
        // LW x5, 0(x1)
        // opcode = 0000011
        // =====================================

        opcode = 7'b0000011;
        funct3 = 3'b010;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 7: LW");
        $display("reg_write   = %b", reg_write);
        $display("mem_read    = %b", mem_read);
        $display("mem_write   = %b", mem_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_src     = %b", alu_src);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 8: SW
        // SW x5, 0(x1)
        // opcode = 0100011
        // =====================================

        opcode = 7'b0100011;
        funct3 = 3'b010;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 8: SW");
        $display("reg_write   = %b", reg_write);
        $display("mem_read    = %b", mem_read);
        $display("mem_write   = %b", mem_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_src     = %b", alu_src);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 9: BEQ
        // =====================================

        opcode = 7'b1100011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 9: BEQ");
        $display("reg_write   = %b", reg_write);
        $display("mem_read    = %b", mem_read);
        $display("mem_write   = %b", mem_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("branch      = %b", branch);
        $display("alu_control = %b", alu_control);


        // =====================================
        // TEST 10: JAL
        // =====================================

        opcode = 7'b1101111;
        funct3 = 3'b000;
        funct7 = 7'b0000000;

        #10;

        $display("----------------------------------------");
        $display("TEST 10: JAL");
        $display("reg_write   = %b", reg_write);
        $display("mem_to_reg  = %b", mem_to_reg);
        $display("alu_src     = %b", alu_src);
        $display("jump        = %b", jump);


        // =====================================
        // COMPLETE
        // =====================================

        $display("========================================");
        $display("CONTROL UNIT SIMULATION COMPLETE");
        $display("========================================");

        $finish;

    end

endmodule