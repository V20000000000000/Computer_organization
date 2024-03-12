`timescale 1ns / 1ps
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

    reg [31:0]R[4:0];

    always @(Rs_addr)
    begin
        case (Rs_addr)
            0: Rs_data <= R[0];
            1: Rs_data <= R[1];
            2: Rs_data <= R[2];
            3: Rs_data <= R[3];
            4: Rs_data <= R[4];
            5: Rs_data <= R[5];
            6: Rs_data <= R[6];
            7: Rs_data <= R[7];
            8: Rs_data <= R[8];
            9: Rs_data <= R[9];
            10: Rs_data <= R[10];
            11: Rs_data <= R[11];
            12: Rs_data <= R[12];
            13: Rs_data <= R[13];
            14: Rs_data <= R[14];
            15: Rs_data <= R[15];
            16: Rs_data <= R[16];
            17: Rs_data <= R[17];
            18: Rs_data <= R[18];
            19: Rs_data <= R[19];
            20: Rs_data <= R[20];
            21: Rs_data <= R[21];
            22: Rs_data <= R[22];
            23: Rs_data <= R[23];
            24: Rs_data <= R[24];
            25: Rs_data <= R[25];
            26: Rs_data <= R[26];
            27: Rs_data <= R[27];
            28: Rs_data <= R[28];
            29: Rs_data <= R[29];
            30: Rs_data <= R[30];
            31: Rs_data <= R[31];
            default: Rs_data <= 0;
        endcase
    end

    always @(Rt_addr)
    begin
        case (Rt_addr)
            0: Rt_data <= R[0];
            1: Rt_data <= R[1];
            2: Rt_data <= R[2];
            3: Rt_data <= R[3];
            4: Rt_data <= R[4];
            5: Rt_data <= R[5];
            6: Rt_data <= R[6];
            7: Rt_data <= R[7];
            8: Rt_data <= R[8];
            9: Rt_data <= R[9];
            10: Rt_data <= R[10];
            11: Rt_data <= R[11];
            12: Rt_data <= R[12];
            13: Rt_data <= R[13];
            14: Rt_data <= R[14];
            15: Rt_data <= R[15];
            16: Rt_data <= R[16];
            17: Rt_data <= R[17];
            18: Rt_data <= R[18];
            19: Rt_data <= R[19];
            20: Rt_data <= R[20];
            21: Rt_data <= R[21];
            22: Rt_data <= R[22];
            23: Rt_data <= R[23];
            24: Rt_data <= R[24];
            25: Rt_data <= R[25];
            26: Rt_data <= R[26];
            27: Rt_data <= R[27];
            28: Rt_data <= R[28];
            29: Rt_data <= R[29];
            30: Rt_data <= R[30];
            31: Rt_data <= R[31];
            default: Rt_data <= 0;
        endcase
    end


endmodule
