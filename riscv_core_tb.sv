`timescale 1ns/1ps

module riscv_core_tb;

    // =========================================================
    // CLOCK AND RESET
    // =========================================================

    logic clk;
    logic reset;


    // =========================================================
    // RISC-V CORE
    // =========================================================

    riscv_core uut (
        .clk(clk),
        .reset(reset)
    );


    // =========================================================
    // PERFORMANCE COUNTERS
    // =========================================================

    integer cycle_count;

    integer instruction_count;

    integer stall_count;

    integer forward_a_count;
    integer forward_b_count;

    integer forwarding_event_count;


    // =========================================================
    // CLOCK
    // =========================================================

    always #5 clk = ~clk;

// =========================================================
// PERFORMANCE MONITOR
// =========================================================
//
// Count instructions at the end of the pipeline.
//
// Register-writing instructions:
//     mem_wb_reg_write = 1
//
// Store instruction:
//     ex_mem_mem_write = 1
//
// This avoids counting NOPs and avoids counting the same
// instruction multiple times while it is stalled.
//
// =========================================================

always @(posedge clk) begin

    if (reset) begin

        cycle_count = 0;

        instruction_count = 0;

        stall_count = 0;

        forward_a_count = 0;

        forward_b_count = 0;

        forwarding_event_count = 0;

    end

    else begin

        // -----------------------------------------------------
        // TOTAL CLOCK CYCLES
        // -----------------------------------------------------

        cycle_count = cycle_count + 1;


        // -----------------------------------------------------
        // HAZARD STALLS
        // -----------------------------------------------------

        if (uut.hazard_control_stall) begin

            stall_count = stall_count + 1;

        end


        // -----------------------------------------------------
        // FORWARD-A EVENTS
        // -----------------------------------------------------

        if (uut.forward_a != 2'b00) begin

            forward_a_count = forward_a_count + 1;

        end


        // -----------------------------------------------------
        // FORWARD-B EVENTS
        // -----------------------------------------------------

        if (uut.forward_b != 2'b00) begin

            forward_b_count = forward_b_count + 1;

        end


        // -----------------------------------------------------
        // TOTAL FORWARDING EVENTS
        // -----------------------------------------------------

        if (
            (uut.forward_a != 2'b00) ||
            (uut.forward_b != 2'b00)
        ) begin

            forwarding_event_count =
                forwarding_event_count + 1;

        end


        // -----------------------------------------------------
        // INSTRUCTION RETIREMENT
        // -----------------------------------------------------
        //
        // Count:
        //
        // 1. Instructions that write a register
        // 2. Store instructions
        //
        // NOPs do not write registers and are not stores,
        // therefore they are automatically excluded.
        //
        // -----------------------------------------------------

        if (
            uut.mem_wb_reg_write &&
            (uut.mem_wb_rd != 5'd0)
        ) begin

            instruction_count =
                instruction_count + 1;

        end

        else if (
            uut.ex_mem_mem_write
        ) begin

            instruction_count =
                instruction_count + 1;

        end

    end

end


    // =========================================================
    // MAIN TEST
    // =========================================================

    initial begin

        // -----------------------------------------------------
        // WAVEFORM
        // -----------------------------------------------------

        $dumpfile("riscv_final_performance.vcd");

        $dumpvars(0, riscv_core_tb);


        // -----------------------------------------------------
        // INITIALIZATION
        // -----------------------------------------------------

        clk   = 1'b0;

        reset = 1'b1;


        // -----------------------------------------------------
        // HEADER
        // -----------------------------------------------------

        $display("");
        $display("================================================");
        $display("       32-BIT RISC-V PERFORMANCE EVALUATION");
        $display("================================================");
        $display("");


        // -----------------------------------------------------
        // RESET
        // -----------------------------------------------------

        #20;

        reset = 1'b0;


        // -----------------------------------------------------
        // INITIAL REGISTER VALUES
        // -----------------------------------------------------

        uut.register_file_unit.registers[1] = 32'd10;

        uut.register_file_unit.registers[2] = 32'd5;


        $display("RESET RELEASED");

        $display("Performance test started.");

        $display("");


        // -----------------------------------------------------
        // RUN PROCESSOR
        // -----------------------------------------------------

        #350;


        // =====================================================
        // PERFORMANCE RESULTS
        // =====================================================

        $display("");
        $display("================================================");
        $display("          PERFORMANCE RESULTS");
        $display("================================================");


        // -----------------------------------------------------
        // Cycles
        // -----------------------------------------------------

        $display("");

        $display("Total Clock Cycles       = %0d",
                 cycle_count);


        // -----------------------------------------------------
        // Instructions
        // -----------------------------------------------------

        $display("Instructions Executed    = %0d",
                 instruction_count);


        // -----------------------------------------------------
        // Stalls
        // -----------------------------------------------------

        $display("Hazard Stall Cycles      = %0d",
                 stall_count);


        // -----------------------------------------------------
        // Forwarding
        // -----------------------------------------------------

        $display("Forward-A Events         = %0d",
                 forward_a_count);

        $display("Forward-B Events         = %0d",
                 forward_b_count);

        $display("Forwarding Events        = %0d",
                 forwarding_event_count);


        // =====================================================
        // CPI
        // =====================================================

        if (instruction_count > 0) begin

            $display("");

            $display("CPI                      = %.3f",
                real'(cycle_count) /
                real'(instruction_count));

        end

        else begin

            $display("");

            $display("CPI                      = N/A");

        end


        // =====================================================
        // CLOCK INFORMATION
        // =====================================================

        $display("");

        $display("Clock Period             = 10 ns");

        $display("Clock Frequency          = 100 MHz");


        // =====================================================
        // EXECUTION TIME
        // =====================================================

        $display("");

        $display("Execution Time           = %0d ns",
                 cycle_count * 10);


        // =====================================================
        // FINAL REGISTER STATE
        // =====================================================

        $display("");
        $display("================================================");
        $display("             FINAL REGISTER STATE");
        $display("================================================");

        $display("");

        $display("x5  = %0d",
                 uut.register_file_unit.registers[5]);

        $display("x6  = %0d",
                 uut.register_file_unit.registers[6]);

        $display("x7  = %0d",
                 uut.register_file_unit.registers[7]);

        $display("x8  = %0d",
                 uut.register_file_unit.registers[8]);

        $display("x9  = %0d",
                 uut.register_file_unit.registers[9]);

        $display("x10 = %0d",
                 uut.register_file_unit.registers[10]);

        $display("x11 = %0d",
                 uut.register_file_unit.registers[11]);

        $display("x12 = %0d",
                 uut.register_file_unit.registers[12]);

        $display("x13 = %0d",
                 uut.register_file_unit.registers[13]);


        // =====================================================
        // DATA MEMORY
        // =====================================================

        $display("");
        $display("DATA MEMORY");
        $display("--------------------------------");

        $display("Memory[0] = %0d",
                 uut.data_memory_unit.memory[0]);

        $display("Memory[1] = %0d",
                 uut.data_memory_unit.memory[1]);


        // =====================================================
        // FUNCTIONAL VERIFICATION
        // =====================================================

        $display("");
        $display("================================================");
        $display("          FUNCTIONAL VERIFICATION");
        $display("================================================");


        if (
            (uut.register_file_unit.registers[5]  == 32'd15)  &&
            (uut.register_file_unit.registers[6]  == 32'd10)  &&
            (uut.register_file_unit.registers[7]  == 32'd0)   &&
            (uut.register_file_unit.registers[8]  == 32'd15)  &&
            (uut.register_file_unit.registers[9]  == 32'd15)  &&
            (uut.register_file_unit.registers[10] == 32'd15)  &&
            (uut.register_file_unit.registers[11] == 32'd100) &&
            (uut.register_file_unit.registers[12] == 32'd100) &&
            (uut.register_file_unit.registers[13] == 32'd105) &&
            (uut.data_memory_unit.memory[1] == 32'd100)
        ) begin

            $display("");

            $display("FUNCTIONAL VERIFICATION  : PASS");

        end

        else begin

            $display("");

            $display("FUNCTIONAL VERIFICATION  : FAIL");

        end


        // =====================================================
        // PERFORMANCE SUMMARY
        // =====================================================

        $display("");
        $display("================================================");
        $display("          PERFORMANCE SUMMARY");
        $display("================================================");

        $display("");

        $display("Instructions Executed    = %0d",
                 instruction_count);

        $display("Total Cycles             = %0d",
                 cycle_count);

        $display("Stall Cycles             = %0d",
                 stall_count);

        $display("Forwarding Events        = %0d",
                 forwarding_event_count);

        if (instruction_count > 0) begin

            $display("Measured CPI             = %.3f",
                real'(cycle_count) /
                real'(instruction_count));

        end


        // =====================================================
        // COMPLETE
        // =====================================================

        $display("");
        $display("================================================");
        $display("       FINAL PERFORMANCE TEST COMPLETE");
        $display("================================================");
        $display("");


        $finish;

    end

endmodule