#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <algorithm>
#include <cmath>
#include <iomanip>
#include <bitset>

using namespace std;

// Function prototypes
void parseInstruction(const string& line, unsigned int& reg1, unsigned int& reg2, unsigned int& shiftAmt, string& funct, bool& carry);
string decodeFunction(const string& funct);
bool testALU(const string& instruction, const string& expectedOutput, int lineNum);
string zeroDetect(unsigned int num);
bool hasCarry(string binary1, string binary2);
void removeSpaces(string &str);
string intToBinaryString(unsigned int num, unsigned int length);
unsigned int binaryToDecimal(string binaryString);
string decimalToHexadecimal(unsigned int decimalNum);

void removeSpaces(string &str) {
    str.erase(remove_if(str.begin(), str.end(), ::isspace), str.end());
}

string decimalToHexadecimal(unsigned int decimalNum) {
    stringstream ss;
    ss << setw(8) << setfill('0') << hex << decimalNum; // Convert decimal to hexadecimal
    return ss.str();
}

string intToBinaryString(unsigned int num, unsigned int length) {
    string binary = "";
    while (num > 0) {
        binary = (num % 2 == 0 ? "0" : "1") + binary;
        num /= 2;
    }
    // Pad the binary string with leading zeros if necessary
    while (binary.length() < length) {
        binary = "0" + binary;
    }
    return binary;
}

unsigned int binaryToDecimal(string binaryString) {
    unsigned int decimal = 0;
    unsigned int exponent = 0;

    // Iterate through the binary string from right to left
    for (int i = binaryString.length() - 1; i >= 0; --i) {
        // If the character is '1', add 2 raised to the exponent to the decimal value
        if (binaryString[i] == '1') {
            decimal += pow(2, exponent);
        }
        // Increment the exponent
        exponent++;
    }
    return decimal;
}

bool hasCarry(string binary1, string binary2) {
    bool carry = false; // Initialize carry to false

    // Ensure both binary numbers have the same number of bits
    int maxLength = max(binary1.length(), binary2.length());
    binary1 = string(maxLength - binary1.length(), '0') + binary1;
    binary2 = string(maxLength - binary2.length(), '0') + binary2;

    // Iterate through each bit and check for carry
    for (int i = maxLength - 1; i >= 0; --i) {
        int sum = (binary1[i] - '0') + (binary2[i] - '0') + carry;
        if (sum > 1) {
            carry = true; // If sum is greater than 1, set carry to true
        } else {
            carry = false; // Otherwise, set carry to false
        }
    }

    return carry; // Return the final carry value
}

string zeroDetect(unsigned int num) {
    if (num == 0) {
        return "1"; // Return "1" if num is zero
    } else {
        return "0"; // Otherwise, return "0"
    }
}

void parseInstruction(const string& line, unsigned int& reg1, unsigned int& reg2, unsigned int& shiftAmt, string& funct, bool& carry) {
    stringstream ss(line);
    string temp1, temp2, temp3;
    string hex1, hex2, hex3;

    getline(ss, temp1, '_');
    reg1 = binaryToDecimal(temp1);
    hex1 = decimalToHexadecimal(reg1);
    cout << "Src1: " << temp1 << "  (0x" << hex1 << ")" << "  (" << reg1 << ")" << endl;
    getline(ss, temp2, '_');
    reg2 = binaryToDecimal(temp2);
    hex2 = decimalToHexadecimal(reg2);
    cout << "Src2: " << temp2 << "  (0x" << hex2 << ")" << "  (" << reg2 << ")" << endl;
    getline(ss, temp3, '_');
    shiftAmt = binaryToDecimal(temp3);
    hex3 = decimalToHexadecimal(shiftAmt);
    cout << "Shamt: " << temp3 << "  (0x" << hex3 << ")" << "  (" << shiftAmt << ")" << endl;
    getline(ss, funct, '_');

    carry = hasCarry(temp1, temp2);
}

string decodeFunction(const string& funct) {
    if (funct == "001001") return "Add unsigned";
    if (funct == "001010") return "Subtract unsigned";
    if (funct == "010001") return "And";
    if (funct == "100010") return "Shift right logical";
    return "Unknown";
}

bool testALU(const string& instruction, const string& actualOutput, int lineNum) {
    // Parse instruction
    unsigned int reg1, reg2;
    unsigned int shiftAmt;
    string time;
    string funct;
    bool carry;
    parseInstruction(instruction, reg1, reg2, shiftAmt, funct, carry);

    cout << "Funct: " << funct << endl;

    // Decode function
    string decodedFunct = decodeFunction(funct);

    // Perform ALU operation based on function
    unsigned int result;
    if (decodedFunct == "Add unsigned") {
        result = reg1 + reg2;
        cout << ">> Addu Result, Src1, Src2" << endl;
    } else if (decodedFunct == "Subtract unsigned") {
        result = reg1 - reg2;
        if(reg1 > reg2) {
            carry = false;
        } else {
            carry = true;
        }
        cout << ">> Subu Result, Src1, Src2" << endl;
    } else if (decodedFunct == "And") {
        result = reg1 & reg2;
        cout << ">> And Result, Src1, Src2" << endl;
    } else if (decodedFunct == "Shift right logical") {
        result = reg1 >> shiftAmt;
        cout << ">> Srl Result, Src1, Shamt" << endl;
    }
    time = to_string(20 * lineNum);
    
    // Convert result to binary string
    string expectedOutput = time + "," + intToBinaryString(result, 32) + "," + zeroDetect(result) + "," + (carry ? "1" : "0");

    // Compare actual output with expected output
    if (expectedOutput != actualOutput) {
        cout << "Instruction: " << instruction << endl;
        cout << "Function: " << decodedFunct << endl;
        cout << "Expected: " << expectedOutput << endl;
        cout << "Actual: " << actualOutput << endl;
        return false;
    } else {
        cout << "ALU_result: " << intToBinaryString(result, 32) << " (0x" << decimalToHexadecimal(result) << ") (" << result << ")" << endl;
        cout << "Zero: " << zeroDetect(result) << endl;
        cout << "Carry: " << (carry ? "1" : "0") << endl;
    }
    return true;
}

int main() {
    // Seed the random number generator
    srand(static_cast<unsigned int>(time(0)));

    // Generate ALUin.txt for the next test
    ofstream aluInput("regenerate_ALU_input.txt");
    if (!aluInput) {
        cerr << "Error: Unable to open ALUin.txt for writing!" << endl;
        return 1;
    }

    // Generate random test instructions
    const int numTests = 10;
    for (int i = 0; i < numTests; ++i) {
        unsigned int reg1 = rand() % 4294967295;
        unsigned int reg2 = rand() % 4294967295;
        unsigned int shiftAmt = rand() % 32;
        string funct;
        switch (rand() % 4) {
            case 0: funct = "001001"; break;
            case 1: funct = "001010"; break;
            case 2: funct = "010001"; break;
            case 3: funct = "100010"; break;
        }

        // Convert integers to binary strings
        string reg1Binary = intToBinaryString(reg1, 32);
        string reg2Binary = intToBinaryString(reg2, 32);
        string shiftAmtBinary = intToBinaryString(shiftAmt, 5);

        // Write binary strings to file
        aluInput << reg1Binary << "_"
                 << reg2Binary << "_"
                 << shiftAmtBinary << "_"
                 << funct << endl;
    }
    aluInput.close();

    // Open ALU input and output files
    ifstream aluInputFile("tb_ALU.in");
    ifstream aluOutputFile("tb_ALU.out");
    if (!aluInputFile || !aluOutputFile) {
        cerr << "Error: Unable to open input/output files!" << endl;
        return 1;
    }

    // Perform tests
    string instruction, output;
    int lineNum = 1;
    while (getline(aluInputFile, instruction)) {
        getline(aluOutputFile, output);
        removeSpaces(output);
        cout << "Line Number: " << lineNum << endl;
        if (!testALU(instruction, output, lineNum)) {
            cout << "------------------------------------" << endl;
            cerr << "Test failed at line " << lineNum << endl;
            //cout << aluOutputFile.tellg() << endl; // Print the position of the file pointer
            cout << "------------------------------------" << endl;
            return 1;
        }
        cout << "Test passed at line " << lineNum << endl;
        cout <<"------------------------------------" << endl;
        ++lineNum;
    }

    cout << "All tests passed!" << endl;

    cout << "------------------------------------" << endl;

    // Close files
    aluInputFile.close();
    aluOutputFile.close();

    return 0;
}

