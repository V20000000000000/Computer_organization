def hex_to_bin(hex_string):
    # 將十六進制字符串轉換為整數
    decimal_number = int(hex_string, 16)
    # 將整數轉換為二進制字符串，並去掉開頭的'0b'
    binary_string = bin(decimal_number)[2:]
    # 在二進制字符串前補零，直到長度為8的倍數
    binary_string = binary_string.zfill((len(binary_string) + 7) // 8 * 8)
    return binary_string

def str_to_dec(binary_string):
    # 將二進制字符串轉換為整數
    decimal_number = int(binary_string, 2)
    return decimal_number

def R_type(binary_string):
    opcode = binary_string[0:6]
    rs = binary_string[6:11]
    rt = binary_string[11:16]
    rd = binary_string[16:21]
    shamt = binary_string[21:26]
    funct = binary_string[26:]
    return opcode, rs, rt, rd, shamt, funct

def I_type(binary_string):
    opcode = binary_string[0:6]
    rs = binary_string[6:11]
    rt = binary_string[11:16]
    immediate = binary_string[16:]
    return opcode, rs, rt, immediate

def J_type(binary_string):
    opcode = binary_string[0:6]
    address = binary_string[6:]
    return opcode, address

def analysisMachineCode(binary_string):
    # R-type
    if(binary_string[0:6] == "000000"):
        opcode, rs, rt, rd, shamt, funct_ctrl = R_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", rd: " + str(rd) + ", shamt: " + str(shamt) + ", funct_ctrl: " + str(funct_ctrl))

        if(funct_ctrl == "001011"):  #Addu
            print("Instruction: Addu" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " + " + "$R" + str(str_to_dec(rt)))
        elif(funct_ctrl == "001101"):    #Subu
            print("Instruction: Subu" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " - " + "$R" + str(str_to_dec(rt)))
        elif(funct_ctrl == "100110"):    #Sll
            print("Instruction: Sll" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(shamt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " << " + str(str_to_dec(shamt)))
        elif(funct_ctrl == "110110"):    #Sllv
            print("Instruction: Sllv" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " << " + "$R" + str(str_to_dec(rt)))
        else:
            print("Unknown instruction")

    # I-type
    elif(binary_string[0:6] == "001101"):   #Subiu
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Subiu" + " " + "$R" + str(str_to_dec(rt)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(immediate)))
        print ("Meaning: " + "$R" + str(str_to_dec(rt)) + " = " + "$R" + str(str_to_dec(rs)) + " - " + str(str_to_dec(immediate)))
    elif(binary_string[0:6] == "010000"):   #Sw
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Sw" + " " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + ("($R" + str(str_to_dec(rs))) + ")")
        print ("Meaning: "+ "Memory[$R" + str(str_to_dec(rs)) + " + " + str(str_to_dec(immediate)) + "] = " + "$R" + str(str_to_dec(rt)))
    elif(binary_string[0:6] == "010001"):   #Lw
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Lw" + " " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + ("($R" + str(str_to_dec(rs))) + ")")
        print ("Meaning: "+ "$R" + str(str_to_dec(rt)) + " = " + "Memory[$R" + str(str_to_dec(rs)) + " + " + str(str_to_dec(immediate)) + "]")
    elif(binary_string[0:6] == "101010"):   #Slti
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Slti" + " " + "$R" + str(str_to_dec(rt)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(immediate)))
        print ("Meaning: If $R" + str(str_to_dec(rs)) + " < " + "$R" + str(str_to_dec(immediate)) + ", then $R" + str(str_to_dec(rt)) + " = 1; else $R" + str(str_to_dec(rt)) + " = 0")
    elif(binary_string[0:6] == "010011"):   #Beq
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Beq" + " " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)))
        print ("Meaning: If $R" + str(str_to_dec(rs)) + " == " + str(str_to_dec(rt)) + ", then Output_Adder = Input_Adder + 4 + 4 * " + str(str_to_dec(immediate)))

    # J-type
    elif(binary_string[0:6] == "011100"):   #J
        opcode, address = J_type(binary_string)
        print ("opcode: " + str(opcode) + ", address: " + str(address))
        print("Instruction: J" + " " + str(str_to_dec(address)))
        print ("Meaning: Jump to  {NextPC[31:28] | 4 * " + str(str_to_dec(address)) + "}")

    else:
        print("Unknown instruction")

# 測試
with open('instruction.txt', 'r') as file:
    # 讀取每一行指令
    for line in file:
        # 去除換行符號並將指令轉換為二進制
        binary_string = hex_to_bin(line.strip())
        print("------------------------------------------------------------------------------------------------------------")
        # 輸出機器碼
        print("Machine code: " + binary_string)
        # 分析機器碼
        analysisMachineCode(binary_string)



