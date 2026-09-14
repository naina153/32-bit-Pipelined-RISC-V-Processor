`timescale 1ns/1ps

module alu_tb;

    logic [31:0] a;
    logic [31:0] b;
    logic [3:0]  alu_control;
    logic [31:0] result;
    logic        zero;

    alu dut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    initial begin

        $display("==============================================");
        $display("        32-BIT ALU SIMULATION");
        $display("==============================================");

        // ADD
        a = 32'd10;
        b = 32'd5;
        alu_control = 4'b0000;
        #10;
        $display("ADD : %0d + %0d = %0d | Zero = %b",
                 a, b, result, zero);

        // SUBTRACT
        a = 32'd10;
        b = 32'd5;
        alu_control = 4'b0001;
        #10;
        $display("SUB : %0d - %0d = %0d | Zero = %b",
                 a, b, result, zero);

        // AND
        a = 32'hFFFF0000;
        b = 32'h0F0F0F0F;
        alu_control = 4'b0010;
        #10;
        $display("AND : %h & %h = %h | Zero = %b",
                 a, b, result, zero);

        // OR
        a = 32'hFFFF0000;
        b = 32'h0F0F0F0F;
        alu_control = 4'b0011;
        #10;
        $display("OR  : %h | %h = %h | Zero = %b",
                 a, b, result, zero);

        // XOR
        a = 32'hFFFF0000;
        b = 32'h0F0F0F0F;
        alu_control = 4'b0100;
        #10;
        $display("XOR : %h ^ %h = %h | Zero = %b",
                 a, b, result, zero);

        // ZERO TEST
        a = 32'd10;
        b = 32'd10;
        alu_control = 4'b0001;
        #10;
        $display("ZERO TEST : %0d - %0d = %0d | Zero = %b",
                 a, b, result, zero);

        $display("==============================================");
        $display("        SIMULATION COMPLETED");
        $display("==============================================");

        $finish;
    end

endmodule