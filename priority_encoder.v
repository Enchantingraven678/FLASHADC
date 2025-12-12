`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:52:02
// Design Name: 
// Module Name: priority_encoder
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

module priority_encoder #(parameter N = 255)(
    input  [N-1:0] therm,
    output reg [7:0] bin_out
);

    integer i;

    always @(*) begin
        bin_out = 8'd0;

        // scan 0 → N-1, highest 1 wins
        for (i = 0; i < N; i = i + 1) begin
            if (therm[i] == 1'b1)
                bin_out = i;   // <<< FIXED HERE
        end
    end

endmodule

