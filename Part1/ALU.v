`define ADDU 6'b001001
`define SUBU 6'b001010
`define SLL 6'b100001
`define SLLV 6'b110101

module ALU
(
    input [31:0] rs_data,
    input [31:0] rt_data,
    input [5:0] funct,
    input [4:0] shamt,
    output reg [31:0] result
);

always @(*)
begin
    case(funct)
        `ADDU: result = rs_data + rt_data;
        `SUBU: result = rs_data - rt_data;
        `SLL: result = rs_data << shamt;
        `SLLV: result = rs_data << rt_data;
        default: result = 32'b0;
    endcase
end    

endmodule