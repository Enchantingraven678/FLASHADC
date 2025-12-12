`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 23:40:00
// Design Name: 
// Module Name: bubble_corrector
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


module bubble_corrector#(parameter N = 255)(input  [N-1:0] therm_in,
    output [N-1:0] therm_clean

    );
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : bubble_fix
            if (i == 0) begin
                assign therm_clean[i] = therm_in[i] | therm_in[i+1];
            end
            else if (i == N-1) begin
                assign therm_clean[i] = therm_in[i] | therm_in[i-1];
            end
            else begin
                assign therm_clean[i] =
                    therm_in[i] | (therm_in[i-1] & therm_in[i+1]);
            end
        end
    endgenerate

endmodule
