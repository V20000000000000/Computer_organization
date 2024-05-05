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

def Hex_to_dec(hex_string):
    # 將十六進制字符串轉換為整數
    decimal_number = int(hex_string, 16)
    return decimal_number

def dec_to_Hex(hex_string):
    # 將十進制字符串轉換為8位十六進制字符串
    hex_number = hex(int(hex_string))[2:]
    hex_number = hex_number.zfill(8)
    return hex_number

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

def analysisMachineCode(binary_string, dataMemory, registerFile, file):
    # R-type
    if(binary_string[0:6] == "000000"):
        opcode, rs, rt, rd, shamt, funct_ctrl = R_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", rd: " + str(rd) + ", shamt: " + str(shamt) + ", funct_ctrl: " + str(funct_ctrl))
        file.write("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", rd: " + str(rd) + ", shamt: " + str(shamt) + ", funct_ctrl: " + str(funct_ctrl) + "\n")
        if(funct_ctrl == "001011"):  #Addu
            print("Instruction: Addu" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " + " + "$R" + str(str_to_dec(rt)))
            print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
            print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
            print("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))])
            file.write("Instruction: Addu" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)) + "\n")
            file.write("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " + " + "$R" + str(str_to_dec(rt)) + "\n")
            file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
            file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
            file.write("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))] + "\n")
            registerFile[int(str_to_dec(rd))] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) + Hex_to_dec(registerFile[int(str_to_dec(rt))])))
            return 4
        
        elif(funct_ctrl == "001101"):    #Subu
            print("Instruction: Subu" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " - " + "$R" + str(str_to_dec(rt)))
            print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
            print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
            print("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))])
            file.write("Instruction: Subu" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)) + "\n")
            file.write("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " - " + "$R" + str(str_to_dec(rt)) + "\n")
            file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
            file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
            file.write("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))] + "\n")
            registerFile[int(str_to_dec(rd))] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) - Hex_to_dec(registerFile[int(str_to_dec(rt))])))
            return 4
        
        elif(funct_ctrl == "100110"):    #Sll
            print("Instruction: Sll" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(shamt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " << " + str(str_to_dec(shamt)))
            print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
            print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
            print("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))])
            file.write("Instruction: Sll" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(shamt)) + "\n")
            file.write("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " << " + str(str_to_dec(shamt)) + "\n")
            file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
            file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
            file.write("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))] + "\n")
            registerFile[int(str_to_dec(rd))] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) << str_to_dec(shamt)))
            return 4
        
        elif(funct_ctrl == "110110"):    #Sllv
            print("Instruction: Sllv" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)))
            print ("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " << " + "$R" + str(str_to_dec(rt)))
            print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
            print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
            print("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))])
            file.write("Instruction: Sllv" + " " + "$R" + str(str_to_dec(rd)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)) + "\n")
            file.write("Meaning: " + "$R" + str(str_to_dec(rd)) + " = " + "$R" + str(str_to_dec(rs)) + " << " + "$R" + str(str_to_dec(rt)) + "\n")
            file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
            file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
            file.write("$R" + str(str_to_dec(rd)) + ": " +registerFile[int(str_to_dec(rd))] + "\n")
            registerFile[int(str_to_dec(rd))] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) << Hex_to_dec(registerFile[int(str_to_dec(rt))])))
            return 4
        
        else:
            print("Unknown instruction")
            file.write("Unknown instruction" + "\n")
            return 0

    # I-type
    elif(binary_string[0:6] == "001101"):   #Subiu
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Subiu" + " " + "$R" + str(str_to_dec(rt)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(immediate)))
        print ("Meaning: " + "$R" + str(str_to_dec(rt)) + " = " + "$R" + str(str_to_dec(rs)) + " - " + str(str_to_dec(immediate)))
        print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
        print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
        print("immediate: " + str(immediate))
        file.write("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate) + "\n")
        file.write("Instruction: Subiu" + " " + "$R" + str(str_to_dec(rt)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(immediate)) + "\n")
        file.write("Meaning: " + "$R" + str(str_to_dec(rt)) + " = " + "$R" + str(str_to_dec(rs)) + " - " + str(str_to_dec(immediate)) + "\n")
        file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
        file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
        file.write("immediate: " + str(immediate) + "\n")
        registerFile[int(str_to_dec(rt))] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) - str_to_dec(immediate)))
        return 4
    
    elif(binary_string[0:6] == "010000"):   #Sw
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Sw" + " " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + ("($R" + str(str_to_dec(rs))) + ")")
        print ("Meaning: "+ "Memory[$R" + str(str_to_dec(rs)) + " + " + str(str_to_dec(immediate)) + "] = " + "$R" + str(str_to_dec(rt)))
        print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
        print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
        print("immediate: " + str(immediate))
        file.write("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate) + "\n")
        file.write("Instruction: Sw" + " " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + ("($R" + str(str_to_dec(rs))) + ")" + "\n")
        file.write("Meaning: "+ "Memory[$R" + str(str_to_dec(rs)) + " + " + str(str_to_dec(immediate)) + "] = " + "$R" + str(str_to_dec(rt)) + "\n")
        file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
        file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
        file.write("immediate: " + str(immediate) + "\n")
        dataMemory[int(str_to_dec(rt))] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) - str_to_dec(immediate)))[0:2]
        dataMemory[int(str_to_dec(rt))+1] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) - str_to_dec(immediate)))[2:4]
        dataMemory[int(str_to_dec(rt))+2] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) - str_to_dec(immediate)))[4:6]
        dataMemory[int(str_to_dec(rt))+3] = str(dec_to_Hex(Hex_to_dec(registerFile[int(str_to_dec(rs))]) - str_to_dec(immediate)))[6:8]
        return 4
    
    elif(binary_string[0:6] == "010001"):   #Lw
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Lw" + " " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + ("($R" + str(str_to_dec(rs))) + ")")
        print ("Meaning: "+ "$R" + str(str_to_dec(rt)) + " = " + "Memory[$R" + str(str_to_dec(rs)) + " + " + str(str_to_dec(immediate)) + "]")
        print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
        print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
        print("immediate: " + str(immediate))
        file.write("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate) + "\n")
        file.write("Instruction: Lw" + " " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + ("($R" + str(str_to_dec(rs))) + ")" + "\n")
        file.write("Meaning: "+ "$R" + str(str_to_dec(rt)) + " = " + "Memory[$R" + str(str_to_dec(rs)) + " + " + str(str_to_dec(immediate)) + "]" + "\n")
        file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
        file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
        file.write("immediate: " + str(immediate) + "\n")
        registerFile[int(str_to_dec(rt))] = str(dataMemory[int(str_to_dec(rs)) + str_to_dec(immediate)]) + str(dataMemory[int(str_to_dec(rs)) + str_to_dec(immediate) + 1]) + str(dataMemory[int(str_to_dec(rs)) + str_to_dec(immediate) + 2]) + str(dataMemory[int(str_to_dec(rs)) + str_to_dec(immediate) + 3])
        return 4
    
    elif(binary_string[0:6] == "101010"):   #Slti
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Slti" + " " + "$R" + str(str_to_dec(rt)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(immediate)))
        print ("Meaning: If $R" + str(str_to_dec(rs)) + " < " + "$R" + str(str_to_dec(immediate)) + ", then $R" + str(str_to_dec(rt)) + " = 1; else $R" + str(str_to_dec(rt)) + " = 0")
        print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
        print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
        print("immediate: " + str(immediate))
        file.write("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate) + "\n")
        file.write("Instruction: Slti" + " " + "$R" + str(str_to_dec(rt)) + ", " + "$R" + str(str_to_dec(rs)) + ", " + str(str_to_dec(immediate)) + "\n")
        file.write("Meaning: If $R" + str(str_to_dec(rs)) + " < " + "$R" + str(str_to_dec(immediate)) + ", then $R" + str(str_to_dec(rt)) + " = 1; else $R" + str(str_to_dec(rt)) + " = 0" + "\n")
        file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
        file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
        file.write("immediate: " + str(immediate) + "\n")
        if(Hex_to_dec(registerFile[int(str_to_dec(rs))]) < str_to_dec(immediate)):
            registerFile[int(str_to_dec(rt))] = "00000001"
        return 4
        
    elif(binary_string[0:6] == "010011"):   #Beq
        opcode, rs, rt, immediate = I_type(binary_string)
        print ("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate))
        print("Instruction: Beq" + " " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)))
        print ("Meaning: If $R" + str(str_to_dec(rs)) + " == " + str(str_to_dec(rt)) + ", then Output_Adder = Input_Adder + 4 + 4 * " + str(str_to_dec(immediate)))
        print("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))])
        print("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))])
        print("immediate: " + str(immediate))
        file.write("opcode: " + str(opcode) + ", rs: " + str(rs) + ", rt: " + str(rt) + ", immediate: " + str(immediate) + "\n")
        file.write("Instruction: Beq" + " " + "$R" + str(str_to_dec(rs)) + ", " + "$R" + str(str_to_dec(rt)) + ", " + str(str_to_dec(immediate)) + "\n")
        file.write("Meaning: If $R" + str(str_to_dec(rs)) + " == " + str(str_to_dec(rt)) + ", then Output_Adder = Input_Adder + 4 + 4 * " + str(str_to_dec(immediate)) + "\n")
        file.write("$R" + str(str_to_dec(rs)) + ": " +registerFile[int(str_to_dec(rs))] + "\n")
        file.write("$R" + str(str_to_dec(rt)) + ": " +registerFile[int(str_to_dec(rt))] + "\n")
        file.write("immediate: " + str(immediate) + "\n")
        if(Hex_to_dec(registerFile[int(rs, 2)]) == Hex_to_dec(registerFile[int(rt, 2)])):
            return (4 + 4 * str_to_dec(immediate))
        else:
            return 4

    # J-type
    elif(binary_string[0:6] == "011100"):   #J
        opcode, address = J_type(binary_string)
        print ("opcode: " + str(opcode) + ", address: " + str(address))
        print("Instruction: J" + " " + str(str_to_dec(address)))
        print ("Meaning: Jump to  {NextPC[31:28] | 4 * " + str(str_to_dec(address)) + "}")
        file.write("opcode: " + str(opcode) + ", address: " + str(address) + "\n")
        file.write("Instruction: J" + " " + str(str_to_dec(address)) + "\n")
        file.write("Meaning: Jump to  {NextPC[31:28] | 4 * " + str(str_to_dec(address)) + "}" + "\n")
        return (4 * str_to_dec(address))

    else:
        print("Unknown instruction")
        file.write("Unknown instruction" + "\n")
        return 0

# 測試

# 建立一個空的列表來存儲資料
dataMemory = []
InstructionMemory = []
registerFile = []

# 開啟DM.txt檔案
with open('DM.txt', 'r') as file:
    # 逐行讀取檔案
    for line in file:
        # 分割每一行資料，並僅保留`FF`部分
        data = line.strip().split('\t')[0]
        # 添加`FF`資料到列表中
        dataMemory.append(data)

# 開啟IM.txt檔案
with open('IM.txt', 'r') as file:
    # 逐行讀取檔案
    for line in file:
        # 分割每一行資料，並僅保留`FF`部分
        data = line.strip().split('\t')[0]
        # 添加`FF`資料到列表中
        InstructionMemory.append(data)

# 開啟RF.txt檔案
with open('RF.txt', 'r') as file:
    # 逐行讀取檔案
    for line in file:
        data = line.strip().split('\t')[0]
        # 移除底線 "_"
        processed_line = data.replace("_", "")
        # 將處理後的資料加入到列表中
        registerFile.append(processed_line)
print(registerFile)

i = 0
count = 0
t = 0
with open('log.txt', 'w') as file:
    while(i <= 128 and count < 100):
        count = count + 1
        print("-----------------------------------------------")
        print("Instruction address: " + str(i))
        print("Instruction: " + InstructionMemory[i] + InstructionMemory[i+1] + InstructionMemory[i+2] + InstructionMemory[i+3])
        file.write("-----------------------------------------------\n")
        file.write("Instruction address: " + str(i) + "\n")
        file.write("Instruction: " + InstructionMemory[i] + InstructionMemory[i+1] + InstructionMemory[i+2] + InstructionMemory[i+3] + "\n")
        file.write("\n")
        print("")
        Hex_string = InstructionMemory[i] + InstructionMemory[i+1] + InstructionMemory[i+2] + InstructionMemory[i+3]
        print("Machine code: " + Hex_string)
        file.write("Machine code: " + Hex_string + "\n")
        binary_string = hex_to_bin(Hex_string)
        if(binary_string[0:6] != "011100"):
            i = i + analysisMachineCode(binary_string, dataMemory, registerFile, file)
        else:
            i = analysisMachineCode(binary_string, dataMemory, registerFile, file)
        print("")
        print("Next Instruction address: " + str(i))
        print("Next Instruction: " + InstructionMemory[i] + InstructionMemory[i+1] + InstructionMemory[i+2] + InstructionMemory[i+3])
        print("")
        print("time: " + str(t) + "ns")
        file.write("\n")
        file.write("Next Instruction address: " + str(i) + "\n")
        file.write("Next Instruction: " + InstructionMemory[i] + InstructionMemory[i+1] + InstructionMemory[i+2] + InstructionMemory[i+3] + "\n")
        file.write("\n")
        file.write("time: " + str(t) + "ns\n")
        t = t + 20

# 在程式最後添加以下代碼來將資料寫入文件中

# 寫入 RF_out.txt
with open('RF_out.txt', 'w') as file:
    for data in registerFile:
        file.write(data + '\n')

# 寫入 DM_out.txt
with open('DM_out.txt', 'w') as file:
    for data in dataMemory:
        file.write(data + '\n')



