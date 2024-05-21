; Example of Part 3 (Final CPU)
;  ________________________________________________________________________________________________________
; |  InstrAddr  |   Instruction           		|   Binary Code                     	  |   Hexadecimal  |
; |             |                         		|  OPCode | Rs  | Rt  | immediate		  |                |
; |             |                               |  OPCode | Rs  | Rt  | Rd  |Shamt| Funct |                |
	0x0000_0000		lw		$R10, 0($R0)		; 0b010001_00000_01010_0000000000000000   => 0x44_0A_00_00
	0x0000_0004		addu	$R11, $R10, $R10  	; 0b000000_01010_01010_01011_00000_001011 => 0x01_4A_58_0B