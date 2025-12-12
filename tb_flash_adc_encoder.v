`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2025 09:57:19
// Design Name: 
// Module Name: tb_flash_adc_encoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
module tb_flash_adc_encoder;

    parameter N = 255;

    reg                 clk;
    reg  [N-1:0]        therm_in;
    wire [7:0]          code_out;

    integer i;
    integer test;
    integer highest_1;
    integer errors = 0;
    integer bubble_pos;

    // DUT
    flash_adc_encoder_top #(N) dut (
        .clk(clk),
        .therm_in(therm_in),
        .code_out(code_out)
    );

    // ------------------------------
    // CLOCK GENERATION (100 MHz)
    // ------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ------------------------------
    // TESTBENCH MAIN PROCESS
    // ------------------------------
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_flash_adc_encoder);

        for (test = 0; test < 100; test = test + 1) begin

            // -------------------------------------
            // 1) RESET thermometer
            // -------------------------------------
            for (i = 0; i < N; i = i + 1)
                therm_in[i] = 1'b0;

            // -------------------------------------
            // 2) Generate safe highest_1 (0..254)
            // -------------------------------------
            highest_1 = $random;            // may be negative
            if (highest_1 < 0)
                highest_1 = -highest_1;     // force positive

            highest_1 = highest_1 % N;      // clamp 0..254


            // -------------------------------------
            // 3) Generate IDEAL thermometer pattern
            // -------------------------------------
            for (i = 0; i < N; i = i + 1)
                therm_in[i] = (i <= highest_1) ? 1'b1 : 1'b0;


            // -------------------------------------
            // 4) Inject EXACTLY ONE bubble (safe)
            // -------------------------------------
            bubble_pos = $random;
            if (bubble_pos < 0)
                bubble_pos = -bubble_pos;

            bubble_pos = bubble_pos % (N-2);

            therm_in[bubble_pos] = ~therm_in[bubble_pos];


            // -------------------------------------
            // 5) Wait ONE pipeline cycle
            // -------------------------------------
            @(posedge clk);


            // -------------------------------------
            // 6) Compare output
            // -------------------------------------
            if (code_out !== highest_1[7:0]) begin
                $display("ERROR: Test=%0d Highest_1=%0d Output=%0d BubbleAt=%0d",
                         test, highest_1, code_out, bubble_pos);
                errors = errors + 1;
            end
            else begin
                $display("PASS : Test=%0d Output=%0d", test, code_out);
            end

        end

        // -------------------------------------
        // 7) Summary
        // -------------------------------------
        $display("\n======================================");
        $display(" TEST COMPLETE - TOTAL ERRORS = %0d", errors);
        $display("======================================\n");

        $finish;

    end

endmodule

