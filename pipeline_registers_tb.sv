`timescale 1ns/1ps

module pipeline_registers_tb;

    logic clk;
    logic reset;
    logic flush;
    logic enable;


    // =========================================================
    // IF/ID SIGNALS
    // =========================================================

    logic [31:0] if_pc_in;
    logic [31:0] if_instruction_in;

    logic [31:0] if_pc_out;
    logic [31:0] if_instruction_out;


    // =========================================================
    // ID/EX SIGNALS
    // =========================================================

    logic [31:0] id_pc_in;

    logic [31:0] id_rs1_data_in;
    logic [31:0] id_rs2_data_in;

    logic [31:0] id_immediate_in;

    logic [4:0] id_rs1_in;
    logic [4:0] id_rs2_in;
    logic [4:0] id_rd_in;

    logic [2:0] id_funct3_in;
    logic [6:0] id_funct7_in;

    // Control inputs
    logic id_reg_write_in;
    logic id_mem_read_in;
    logic id_mem_write_in;
    logic id_mem_to_reg_in;

    logic id_alu_src_in;
    logic id_branch_in;
    logic id_jump_in;

    logic [3:0] id_alu_control_in;


    // ID/EX outputs

    logic [31:0] id_pc_out;

    logic [31:0] id_rs1_data_out;
    logic [31:0] id_rs2_data_out;

    logic [31:0] id_immediate_out;

    logic [4:0] id_rs1_out;
    logic [4:0] id_rs2_out;
    logic [4:0] id_rd_out;

    logic [2:0] id_funct3_out;
    logic [6:0] id_funct7_out;

    // Control outputs
    logic id_reg_write_out;
    logic id_mem_read_out;
    logic id_mem_write_out;
    logic id_mem_to_reg_out;

    logic id_alu_src_out;
    logic id_branch_out;
    logic id_jump_out;

    logic [3:0] id_alu_control_out;


    // =========================================================
    // EX/MEM SIGNALS
    // =========================================================

    logic [31:0] ex_alu_result_in;
    logic [31:0] ex_rs2_data_in;
    logic [31:0] ex_branch_target_in;

    logic ex_zero_in;

    logic [4:0] ex_rd_in;
    logic [2:0] ex_funct3_in;

    // Control inputs
    logic ex_reg_write_in;
    logic ex_mem_read_in;
    logic ex_mem_write_in;
    logic ex_mem_to_reg_in;

    logic ex_branch_in;
    logic ex_jump_in;


    // EX/MEM outputs

    logic [31:0] ex_alu_result_out;
    logic [31:0] ex_rs2_data_out;
    logic [31:0] ex_branch_target_out;

    logic ex_zero_out;

    logic [4:0] ex_rd_out;
    logic [2:0] ex_funct3_out;

    // Control outputs
    logic ex_reg_write_out;
    logic ex_mem_read_out;
    logic ex_mem_write_out;
    logic ex_mem_to_reg_out;

    logic ex_branch_out;
    logic ex_jump_out;


    // =========================================================
    // MEM/WB SIGNALS
    // =========================================================

    logic [31:0] mem_memory_data_in;
    logic [31:0] mem_alu_result_in;

    logic [4:0] mem_rd_in;

    logic mem_reg_write_in;
    logic mem_to_reg_in;


    // MEM/WB outputs

    logic [31:0] mem_memory_data_out;
    logic [31:0] mem_alu_result_out;

    logic [4:0] mem_rd_out;

    logic mem_reg_write_out;
    logic mem_to_reg_out;


    // =========================================================
    // IF/ID INSTANCE
    // =========================================================

    if_id if_id_unit (

        .clk(clk),
        .reset(reset),
        .flush(flush),
        .enable(enable),

        .pc_in(if_pc_in),
        .instruction_in(if_instruction_in),

        .pc_out(if_pc_out),
        .instruction_out(if_instruction_out)

    );


    // =========================================================
    // ID/EX INSTANCE
    // =========================================================

    id_ex id_ex_unit (

        .clk(clk),
        .reset(reset),
        .flush(flush),

        .pc_in(id_pc_in),

        .rs1_data_in(id_rs1_data_in),
        .rs2_data_in(id_rs2_data_in),

        .immediate_in(id_immediate_in),

        .rs1_in(id_rs1_in),
        .rs2_in(id_rs2_in),
        .rd_in(id_rd_in),

        .funct3_in(id_funct3_in),
        .funct7_in(id_funct7_in),

        .reg_write_in(id_reg_write_in),
        .mem_read_in(id_mem_read_in),
        .mem_write_in(id_mem_write_in),
        .mem_to_reg_in(id_mem_to_reg_in),

        .alu_src_in(id_alu_src_in),
        .branch_in(id_branch_in),
        .jump_in(id_jump_in),

        .alu_control_in(id_alu_control_in),

        .pc_out(id_pc_out),

        .rs1_data_out(id_rs1_data_out),
        .rs2_data_out(id_rs2_data_out),

        .immediate_out(id_immediate_out),

        .rs1_out(id_rs1_out),
        .rs2_out(id_rs2_out),
        .rd_out(id_rd_out),

        .funct3_out(id_funct3_out),
        .funct7_out(id_funct7_out),

        .reg_write_out(id_reg_write_out),
        .mem_read_out(id_mem_read_out),
        .mem_write_out(id_mem_write_out),
        .mem_to_reg_out(id_mem_to_reg_out),

        .alu_src_out(id_alu_src_out),
        .branch_out(id_branch_out),
        .jump_out(id_jump_out),

        .alu_control_out(id_alu_control_out)

    );


    // =========================================================
    // EX/MEM INSTANCE
    // =========================================================

    ex_mem ex_mem_unit (

        .clk(clk),
        .reset(reset),
        .flush(flush),

        .alu_result_in(ex_alu_result_in),
        .rs2_data_in(ex_rs2_data_in),

        .branch_target_in(ex_branch_target_in),

        .zero_in(ex_zero_in),

        .rd_in(ex_rd_in),
        .funct3_in(ex_funct3_in),

        .reg_write_in(ex_reg_write_in),
        .mem_read_in(ex_mem_read_in),
        .mem_write_in(ex_mem_write_in),
        .mem_to_reg_in(ex_mem_to_reg_in),

        .branch_in(ex_branch_in),
        .jump_in(ex_jump_in),

        .alu_result_out(ex_alu_result_out),
        .rs2_data_out(ex_rs2_data_out),

        .branch_target_out(ex_branch_target_out),

        .zero_out(ex_zero_out),

        .rd_out(ex_rd_out),
        .funct3_out(ex_funct3_out),

        .reg_write_out(ex_reg_write_out),
        .mem_read_out(ex_mem_read_out),
        .mem_write_out(ex_mem_write_out),
        .mem_to_reg_out(ex_mem_to_reg_out),

        .branch_out(ex_branch_out),
        .jump_out(ex_jump_out)

    );


    // =========================================================
    // MEM/WB INSTANCE
    // =========================================================

    mem_wb mem_wb_unit (

        .clk(clk),
        .reset(reset),

        .memory_data_in(mem_memory_data_in),
        .alu_result_in(mem_alu_result_in),

        .rd_in(mem_rd_in),

        .reg_write_in(mem_reg_write_in),
        .mem_to_reg_in(mem_to_reg_in),

        .memory_data_out(mem_memory_data_out),
        .alu_result_out(mem_alu_result_out),

        .rd_out(mem_rd_out),

        .reg_write_out(mem_reg_write_out),
        .mem_to_reg_out(mem_to_reg_out)

    );


    // =========================================================
    // CLOCK
    // =========================================================

    always #5 clk = ~clk;


    // =========================================================
    // MAIN TEST
    // =========================================================

    initial begin

        $dumpfile("pipeline_registers.vcd");
        $dumpvars(0, pipeline_registers_tb);


        // =====================================================
        // INITIAL VALUES
        // =====================================================

        clk = 0;
        reset = 1;
        flush = 0;
        enable = 1;


        // IF/ID

        if_pc_in = 32'b0;
        if_instruction_in = 32'b0;


        // ID/EX

        id_pc_in = 32'b0;

        id_rs1_data_in = 32'b0;
        id_rs2_data_in = 32'b0;

        id_immediate_in = 32'b0;

        id_rs1_in = 5'b0;
        id_rs2_in = 5'b0;
        id_rd_in = 5'b0;

        id_funct3_in = 3'b0;
        id_funct7_in = 7'b0;

        id_reg_write_in = 1'b0;
        id_mem_read_in = 1'b0;
        id_mem_write_in = 1'b0;
        id_mem_to_reg_in = 1'b0;

        id_alu_src_in = 1'b0;
        id_branch_in = 1'b0;
        id_jump_in = 1'b0;

        id_alu_control_in = 4'b0;


        // EX/MEM

        ex_alu_result_in = 32'b0;
        ex_rs2_data_in = 32'b0;
        ex_branch_target_in = 32'b0;

        ex_zero_in = 1'b0;

        ex_rd_in = 5'b0;
        ex_funct3_in = 3'b0;

        ex_reg_write_in = 1'b0;
        ex_mem_read_in = 1'b0;
        ex_mem_write_in = 1'b0;
        ex_mem_to_reg_in = 1'b0;

        ex_branch_in = 1'b0;
        ex_jump_in = 1'b0;


        // MEM/WB

        mem_memory_data_in = 32'b0;
        mem_alu_result_in = 32'b0;

        mem_rd_in = 5'b0;

        mem_reg_write_in = 1'b0;
        mem_to_reg_in = 1'b0;


        // =====================================================
        // RESET
        // =====================================================

        #10;

        reset = 0;

        $display("========================================");
        $display("RESET COMPLETE");
        $display("========================================");


        // =====================================================
        // TEST 1: IF/ID
        // =====================================================

        if_pc_in = 32'h00000004;
        if_instruction_in = 32'h002082B3;

        #10;

        $display("----------------------------------------");
        $display("TEST 1: IF/ID");
        $display("PC          = %h", if_pc_out);
        $display("Instruction = %h", if_instruction_out);


        // =====================================================
        // TEST 2: ID/EX
        // =====================================================

        id_pc_in = 32'h00000004;

        id_rs1_data_in = 32'd10;
        id_rs2_data_in = 32'd5;

        id_immediate_in = 32'd20;

        id_rs1_in = 5'd1;
        id_rs2_in = 5'd2;
        id_rd_in = 5'd5;

        id_funct3_in = 3'b000;
        id_funct7_in = 7'b0000000;

        id_reg_write_in = 1'b1;
        id_mem_read_in = 1'b0;
        id_mem_write_in = 1'b0;
        id_mem_to_reg_in = 1'b0;

        id_alu_src_in = 1'b0;
        id_branch_in = 1'b0;
        id_jump_in = 1'b0;

        id_alu_control_in = 4'b0000;

        #10;

        $display("----------------------------------------");
        $display("TEST 2: ID/EX");
        $display("PC          = %h", id_pc_out);
        $display("RS1 Data    = %0d", id_rs1_data_out);
        $display("RS2 Data    = %0d", id_rs2_data_out);
        $display("Immediate   = %0d", id_immediate_out);
        $display("RD          = %0d", id_rd_out);
        $display("RegWrite    = %b", id_reg_write_out);
        $display("MemToReg    = %b", id_mem_to_reg_out);


        // =====================================================
        // TEST 3: EX/MEM
        // Simulate an LW instruction
        // =====================================================

        ex_alu_result_in = 32'd100;
        ex_rs2_data_in = 32'd0;
        ex_branch_target_in = 32'd200;

        ex_zero_in = 1'b0;

        ex_rd_in = 5'd6;
        ex_funct3_in = 3'b010;

        ex_reg_write_in = 1'b1;
        ex_mem_read_in = 1'b1;
        ex_mem_write_in = 1'b0;
        ex_mem_to_reg_in = 1'b1;

        ex_branch_in = 1'b0;
        ex_jump_in = 1'b0;

        #10;

        $display("----------------------------------------");
        $display("TEST 3: EX/MEM");
        $display("ALU Result  = %0d", ex_alu_result_out);
        $display("RD          = %0d", ex_rd_out);
        $display("MemRead     = %b", ex_mem_read_out);
        $display("MemWrite    = %b", ex_mem_write_out);
        $display("MemToReg    = %b", ex_mem_to_reg_out);
        $display("RegWrite    = %b", ex_reg_write_out);


        // =====================================================
        // TEST 4: MEM/WB
        // =====================================================

        mem_memory_data_in = 32'd555;
        mem_alu_result_in = 32'd100;

        mem_rd_in = 5'd6;

        mem_reg_write_in = 1'b1;
        mem_to_reg_in = 1'b1;

        #10;

        $display("----------------------------------------");
        $display("TEST 4: MEM/WB");
        $display("Memory Data = %0d", mem_memory_data_out);
        $display("ALU Result  = %0d", mem_alu_result_out);
        $display("RD          = %0d", mem_rd_out);
        $display("RegWrite    = %b", mem_reg_write_out);
        $display("MemToReg    = %b", mem_to_reg_out);


        // =====================================================
        // TEST 5: IF/ID STALL
        // =====================================================

        enable = 0;

        if_pc_in = 32'h00000020;
        if_instruction_in = 32'h12345678;

        #10;

        $display("----------------------------------------");
        $display("TEST 5: IF/ID STALL");
        $display("Expected PC remains 4");
        $display("Actual PC = %h", if_pc_out);
        $display("Expected Instruction remains 002082B3");
        $display("Actual Instruction = %h", if_instruction_out);


        // =====================================================
        // TEST 6: PIPELINE FLUSH
        // =====================================================

        enable = 1;
        flush = 1;

        #10;

        $display("----------------------------------------");
        $display("TEST 6: PIPELINE FLUSH");

        $display("IF/ID Instruction = %h",
                 if_instruction_out);

        $display("ID/EX RegWrite = %b",
                 id_reg_write_out);

        $display("ID/EX MemToReg = %b",
                 id_mem_to_reg_out);

        $display("EX/MEM RegWrite = %b",
                 ex_reg_write_out);

        $display("EX/MEM MemToReg = %b",
                 ex_mem_to_reg_out);


        // =====================================================
        // COMPLETE
        // =====================================================

        $display("========================================");
        $display("PIPELINE REGISTER SIMULATION COMPLETE");
        $display("========================================");

        $finish;

    end

endmodule