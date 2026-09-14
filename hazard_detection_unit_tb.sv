`timescale 1ns/1ps

module hazard_detection_unit_tb;

    logic [4:0] if_id_rs1;
    logic [4:0] if_id_rs2;

    logic [6:0] if_id_opcode;

    logic       id_ex_mem_read;
    logic [4:0] id_ex_rd;

    logic       pc_write;
    logic       if_id_write;
    logic       control_stall;


    // =========================================================
    // DUT
    // =========================================================

    hazard_detection_unit dut (

        .if_id_rs1(if_id_rs1),
        .if_id_rs2(if_id_rs2),

        .if_id_opcode(if_id_opcode),

        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_rd(id_ex_rd),

        .pc_write(pc_write),
        .if_id_write(if_id_write),
        .control_stall(control_stall)

    );


    // =========================================================
    // TEST PROCEDURE
    // =========================================================

    task automatic check_result;

        input logic expected_stall;
        input logic [127:0] test_name;

        begin

            #1;

            if (control_stall !== expected_stall) begin

                $display(
                    "FAIL: %0s | stall=%b expected=%b",
                    test_name,
                    control_stall,
                    expected_stall
                );

            end

            else begin

                $display(
                    "PASS: %0s | stall=%b",
                    test_name,
                    control_stall
                );

            end

        end

    endtask


    // =========================================================
    // MAIN TEST
    // =========================================================

    initial begin

        $display("");
        $display("================================================");
        $display("       HAZARD DETECTION UNIT TEST");
        $display("================================================");
        $display("");


        // -----------------------------------------------------
        // TEST 1
        // No load in EX
        // -----------------------------------------------------

        id_ex_mem_read = 1'b0;
        id_ex_rd      = 5'd5;

        if_id_rs1     = 5'd5;
        if_id_rs2     = 5'd2;

        // R-type instruction
        if_id_opcode  = 7'b0110011;

        check_result(
            1'b0,
            "No load in EX"
        );


        // -----------------------------------------------------
        // TEST 2
        // Load x5 followed by ADD using x5
        //
        // LW  x5, 0(x1)
        // ADD x6, x5, x2
        // -----------------------------------------------------

        id_ex_mem_read = 1'b1;
        id_ex_rd      = 5'd5;

        if_id_rs1     = 5'd5;
        if_id_rs2     = 5'd2;

        // R-type ADD
        if_id_opcode  = 7'b0110011;

        check_result(
            1'b1,
            "LW followed by ADD using rs1"
        );


        // -----------------------------------------------------
        // TEST 3
        // Load x5 followed by ADD using x5 as rs2
        //
        // LW  x5, 0(x1)
        // ADD x6, x2, x5
        // -----------------------------------------------------

        id_ex_mem_read = 1'b1;
        id_ex_rd      = 5'd5;

        if_id_rs1     = 5'd2;
        if_id_rs2     = 5'd5;

        if_id_opcode  = 7'b0110011;

        check_result(
            1'b1,
            "LW followed by ADD using rs2"
        );


        // -----------------------------------------------------
        // TEST 4
        // Load x5 followed by ADDI using x2
        //
        // LW   x5, 0(x1)
        // ADDI x6, x2, 10
        //
        // No dependency on x5.
        // -----------------------------------------------------

        id_ex_mem_read = 1'b1;
        id_ex_rd      = 5'd5;

        if_id_rs1     = 5'd2;
        if_id_rs2     = 5'd5;

        // I-type ALU
        if_id_opcode  = 7'b0010011;

        check_result(
            1'b0,
            "LW followed by unrelated ADDI"
        );


        // -----------------------------------------------------
        // TEST 5
        // x0 must never create a hazard
        //
        // LW x0, 0(x1)
        // ADD x6, x0, x2
        // -----------------------------------------------------

        id_ex_mem_read = 1'b1;
        id_ex_rd      = 5'd0;

        if_id_rs1     = 5'd0;
        if_id_rs2     = 5'd2;

        if_id_opcode  = 7'b0110011;

        check_result(
            1'b0,
            "Load destination x0"
        );


        // -----------------------------------------------------
        // TEST 6
        // Store uses both rs1 and rs2
        //
        // LW x5, 0(x1)
        // SW x5, 4(x2)
        //
        // Hazard because store uses x5 as rs2.
        // -----------------------------------------------------

        id_ex_mem_read = 1'b1;
        id_ex_rd      = 5'd5;

        if_id_rs1     = 5'd2;
        if_id_rs2     = 5'd5;

        // S-type
        if_id_opcode  = 7'b0100011;

        check_result(
            1'b1,
            "LW followed by SW using loaded value"
        );


        // -----------------------------------------------------
        // TEST 7
        // Branch uses both rs1 and rs2
        //
        // LW x5, 0(x1)
        // BEQ x5, x2, label
        // -----------------------------------------------------

        id_ex_mem_read = 1'b1;
        id_ex_rd      = 5'd5;

        if_id_rs1     = 5'd5;
        if_id_rs2     = 5'd2;

        // B-type
        if_id_opcode  = 7'b1100011;

        check_result(
            1'b1,
            "LW followed by BEQ using loaded value"
        );


        // -----------------------------------------------------
        // FINAL
        // -----------------------------------------------------

        $display("");
        $display("================================================");
        $display("      HAZARD UNIT TEST COMPLETED");
        $display("================================================");
        $display("");

        $finish;

    end

endmodule