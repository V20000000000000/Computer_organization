   ______________________________________________________________________________________________________
  |  InstrAddr    |   Instruction           	|  	Binary Code                          	|  Hexadecimal |
  |               |                         	|  	OPCode | Rs  | Rt  | immediate			|              |
  |               |                          |  	OPCode | Rs  | Rt  | Rd  |Shamt| Funct |              |
  | 0x0000_0000	| addu  $R10, $R1,  $R2    |    0b000000_00001_00010_01010_00000_001011 | 0x00_22_50_0B|
  | 0x0000_0004	| subu  $R11, $R2,  $R1	   |    0b000000_00010_00001_01011_00000_001101 | 0x00_41_58_0D|
  | 0x0000_0008	| sll	  $R12, $R1, 0x4	   |    0b000000_00001_01011_01100_00100_100110 | 0x00_2B_61_26|
  | 0x0000_000C	| sllv  $R13, $R1, $R2	   |    0b000000_00001_00010_01101_00000_110110 | 0x00_22_68_36|
  | 0x0000_0010	| Subiu $R14, $R1, 0x1  	|    0b001101_00001_01110_0000000000000001   | 0x34_2E_00_01|
  | 0x0000_0014	| sw		$R1,  4($R0)	   |    0b010000_00000_00001_0000000000000100   | 0x40_01_00_04|
  | 0x0000_0018	| lw		$R15, 0($R0)   	|    0b010001_00000_01111_0000000000000000   | 0x44_0F_00_00|
  | 0x0000_001C	| Slti	$R16, $R1, 0x3	   |    0b101010_00001_10000_0000000000000011   | 0xA8_30_00_03|
  | 0x0000_0020	| lw  	$R22, 8($R0)		|    0b010001_00000_10110_0000000000001000	| 0x44_16_00_08|
  | 0x0000_0024	| lw  	$R22, 24($R22)		|    0b010001_10110_10110_0000000000011000	| 0x46_D6_00_18| 
  | 0x0000_0028   | addu   $R22, $R22, $R1	| 	  0b000000_10110_00001_10110_00000_001011	| 0x02_C1_B0_0B| 