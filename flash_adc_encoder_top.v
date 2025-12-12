`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:56:41
// Design Name: 
// Module Name: flash_adc_encoder_top
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


module flash_adc_encoder_top #(parameter N = 255)(
    input               clk,
    input  [N-1:0]      therm_in,
    output reg [7:0]    code_out
);

    wire [N-1:0] therm_clean;
    wire [7:0]   bin_code;

    // Stage 1: bubble removal
    bubble_corrector #(N) u1 (
        .therm_in(therm_in),
        .therm_clean(therm_clean)
    );

    // Stage 2: priority encoder
    priority_encoder #(N) u2 (
        .therm(therm_clean),
        .bin_out(bin_code)
    );

    // Stage 3: pipeline register
    always @(posedge clk) begin
        code_out <= bin_code;
    end

endmodule
