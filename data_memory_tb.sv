`timescale 1ns/1ps

module data_memory_tb;

    logic        clk;

    logic [31:0] address;
    logic [31:0] write_data;

    logic        mem_read;
    logic        mem_write;

    logic [31:0] read_data;


    data_memory uut (
        .clk(clk),
        .address(address),
        .write_data(write_data),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(read_data)
    );


    // Clock generation
    always #5 clk = ~clk;


    initial begin

        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);

        clk = 0;

        address   = 32'b0;
        write_data = 32'b0;

        mem_read  = 0;
        mem_write = 0;


        // =====================================
        // TEST 1: READ INITIAL VALUE
        // memory[0] = 100
        // address = 0x00
        // =====================================

        address = 32'h00000000;
        mem_read = 1;

        #10;

        $display("------------------------------------");
        $display("TEST 1: READ");
        $display("Address    = %h", address);
        $display("Read Data  = %0d", read_data);


        // =====================================
        // TEST 2: READ MEMORY[1]
        // memory[1] = 200
        // address = 0x04
        // =====================================

        address = 32'h00000004;

        #10;

        $display("------------------------------------");
        $display("TEST 2: READ");
        $display("Address    = %h", address);
        $display("Read Data  = %0d", read_data);


        // =====================================
        // TEST 3: WRITE 555 TO ADDRESS 0x08
        // =====================================

        mem_read  = 0;
        mem_write = 1;

        address    = 32'h00000008;
        write_data = 32'd555;

        #10;

        $display("------------------------------------");
        $display("TEST 3: WRITE");
        $display("Address    = %h", address);
        $display("Write Data = %0d", write_data);


        // =====================================
        // TEST 4: READ BACK 555
        // =====================================

        mem_write = 0;
        mem_read  = 1;

        #10;

        $display("------------------------------------");
        $display("TEST 4: READ AFTER WRITE");
        $display("Address    = %h", address);
        $display("Read Data  = %0d", read_data);


        // =====================================
        // TEST 5: WRITE 999 TO ADDRESS 0x0C
        // =====================================

        mem_read  = 0;
        mem_write = 1;

        address    = 32'h0000000C;
        write_data = 32'd999;

        #10;

        $display("------------------------------------");
        $display("TEST 5: WRITE");
        $display("Address    = %h", address);
        $display("Write Data = %0d", write_data);


        // =====================================
        // TEST 6: READ BACK 999
        // =====================================

        mem_write = 0;
        mem_read  = 1;

        #10;

        $display("------------------------------------");
        $display("TEST 6: READ AFTER WRITE");
        $display("Address    = %h", address);
        $display("Read Data  = %0d", read_data);


        $display("------------------------------------");
        $display("DATA MEMORY SIMULATION COMPLETE");
        $display("------------------------------------");

        $finish;

    end

endmodule