def hex_to_bin(hex_string):
    # 將十六進制字符串轉換為整數
    decimal_number = int(hex_string, 16)
    # 將整數轉換為二進制字符串，並去掉開頭的'0b'
    binary_string = bin(decimal_number)[2:]
    # 在二進制字符串前補零，直到長度為8的倍數
    binary_string = binary_string.zfill((len(binary_string) + 7) // 8 * 8)
    return binary_string

# 測試
hex_string = "f7f7f7f7"
binary_string = hex_to_bin(hex_string)
opcode = binary_string[0:6]
rs = binary_string[6:11]
rt = binary_string[11:16]
rd = binary_string[16:21]
shamt = binary_string[21:26]
funct = binary_string[26:]

print(binary_string)
print("opcode: " + str(opcode))
print("rs: " + str(rs))
print("rt: " + str(rt))
print("rd: " + str(rd))
print("shamt: " + str(shamt))
print("funct: " + str(funct))



# if(opcode == "00000"):
#     print("R-type")
#     print("rs: " + str(rs))
#     print("rt: " + str(rt))
#     print("rd: " + str(rd))
#     print("shamt: " + str(shamt))
#     print("funct: " + str(funct))

