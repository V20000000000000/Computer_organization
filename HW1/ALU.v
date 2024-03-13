
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/12 20:40:52
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] Src_1,
    input [31:0] Src_2,
    input [5:0] Funct,
    input [4:0] Shamt,
    output [31:0] ALU_result,
    output [0:0] Zero,
    output [0:0] Carry
    );

    reg [31:0] ALU_result_reg;
    reg Carry_reg;

    initial
    begin
	ALU_result_reg = 0;
	Carry_reg = 0;
    end
    	
    assign ALU_result = ALU_result_reg;
    assign Zero = (ALU_result_reg == 0);
    assign Carry = Carry_reg;

    always @(*)
    begin
        if(Funct == 6'b001001)
        begin
            {Carry_reg, ALU_result_reg} <= Src_1 + Src_2;
        end
        else if(Funct == 6'b001010)
        begin
            {Carry_reg, ALU_result_reg} <= Src_1 + ~Src_2 +1;
        end
        else if(Funct == 6'b010001)
        begin
            ALU_result_reg <= Src_1 & Src_2;
            Carry_reg <= 0;
        end
        else if(Funct == 6'b100010)
        begin
            ALU_result_reg <= Src_1 >> Shamt;
            Carry_reg <= 0;
        end
    end    
    
endmodule
