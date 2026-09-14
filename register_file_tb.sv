`timescale 1ns/1ps

module register_file_tb;

    logic clk;
    logic reset;

    logic [4:0] rs1;
    logic [4:0] rs2;

    logic [4:0] rd;
    logic [31:0] write_data;
    logic reg_write;

    logic [31:0] read_data1;
    logic [31:0] read_data2;

    register_file uut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
         $dumpfile("register_file.vcd");
    $dumpvars(0, register_file_tb);

        clk = 0;
        reset = 1;

        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        reg_write = 0;

        #10;

        reset = 0;

        // --------------------------------
        // Test 1: Write x1 = 100
        // --------------------------------

        rd = 5'd1;
        write_data = 32'd100;
        reg_write = 1;

        #10;

        reg_write = 0;

        // Read x1
        rs1 = 5'd1;

        #5;

        $display("REGISTER TEST 1: x1 = %0d", read_data1);

        // --------------------------------
        // Test 2: Write x2 = 200
        // --------------------------------

        rd = 5'd2;
        write_data = 32'd200;
        reg_write = 1;

        #10;

        reg_write = 0;

        rs2 = 5'd2;

        #5;

        $display("REGISTER TEST 2: x2 = %0d", read_data2);

        // --------------------------------
        // Test 3: x0 must remain zero
        // --------------------------------

        rd = 5'd0;
        write_data = 32'd999;
        reg_write = 1;

        #10;

        reg_write = 0;

        rs1 = 5'd0;

        #5;

        $display("ZERO REGISTER TEST: x0 = %0d", read_data1);

        // Finish
        #10;

        $display("=================================");
        $display("REGISTER FILE SIMULATION COMPLETE");
        $display("=================================");

        $finish;

    end

endmodule