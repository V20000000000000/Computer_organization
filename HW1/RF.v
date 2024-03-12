
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/12 20:37:26
// Design Name: 
// Module Name: RF
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


module RF(
    input [4:0] Rs_addr,
    input [4:0] Rt_addr,
    output [31:0] Rs_data,
    output [31:0] Rt_data
    );

    reg [31:0]R[0:31];

    assign Rs_data = R[Rs_addr];
    assign Rt_data = R[Rt_addr];

endmodule
