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
    reg [31:0]Rs;
    reg [31:0]Rt;

    assign Rs_data = Rs;
    assign Rt_data = Rt;

    always @(Rs_addr)
    begin
        case (Rs_addr)
            0: Rs <= R[0];
            1: Rs <= R[1];
            2: Rs <= R[2];
            3: Rs <= R[3];
            4: Rs <= R[4];
            5: Rs <= R[5];
            6: Rs <= R[6];
            7: Rs <= R[7];
            8: Rs <= R[8];
            9: Rs <= R[9];
            10: Rs <= R[10];
            11: Rs <= R[11];
            12: Rs <= R[12];
            13: Rs <= R[13];
            14: Rs <= R[14];
            15: Rs <= R[15];
            16: Rs <= R[16];
            17: Rs <= R[17];
            18: Rs <= R[18];
            19: Rs <= R[19];
            20: Rs <= R[20];
            21: Rs <= R[21];
            22: Rs <= R[22];
            23: Rs <= R[23];
            24: Rs <= R[24];
            25: Rs <= R[25];
            26: Rs <= R[26];
            27: Rs <= R[27];
            28: Rs <= R[28];
            29: Rs <= R[29];
            30: Rs <= R[30];
            31: Rs <= R[31];
            default: Rs <= 0;
        endcase
    end

    always @(Rt_addr)
    begin
        case (Rt_addr)
            0: Rt <= R[0];
            1: Rt <= R[1];
            2: Rt <= R[2];
            3: Rt <= R[3];
            4: Rt <= R[4];
            5: Rt <= R[5];
            6: Rt <= R[6];
            7: Rt <= R[7];
            8: Rt <= R[8];
            9: Rt <= R[9];
            10: Rt <= R[10];
            11: Rt <= R[11];
            12: Rt <= R[12];
            13: Rt <= R[13];
            14: Rt <= R[14];
            15: Rt <= R[15];
            16: Rt <= R[16];
            17: Rt <= R[17];
            18: Rt <= R[18];
            19: Rt <= R[19];
            20: Rt <= R[20];
            21: Rt <= R[21];
            22: Rt <= R[22];
            23: Rt <= R[23];
            24: Rt <= R[24];
            25: Rt <= R[25];
            26: Rt <= R[26];
            27: Rt <= R[27];
            28: Rt <= R[28];
            29: Rt <= R[29];
            30: Rt <= R[30];
            31: Rt <= R[31];
            default: Rt <= 0;
        endcase
    end


endmodule
