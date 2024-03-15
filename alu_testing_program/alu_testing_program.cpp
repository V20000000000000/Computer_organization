#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <algorithm>
#include <cmath>

using namespace std;

// Function prototypes
void parseInstruction(const string& line, int& reg1, int& reg2, int& shiftAmt, string& funct, string& carry);
string decodeFunction(const string& funct);
bool testALU(const string& instruction, const string& expectedOutput, int lineNum);
string zeroDetect(int num);
string hasCarry(string binary1, string binary2);
void removeSpaces(string &str);
string intToBinaryString(int num, unsigned int length);
int binaryToDecimal(string binaryString);

void removeSpaces(string &str) {
    str.erase(remove_if(str.begin(), str.end(), ::isspace), str.end());
}

string intToBinaryString(int num, unsigned int length) {
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

int binaryToDecimal(string binaryString) {
    int decimal = 0;
    int exponent = 0;

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

string hasCarry(string binary1, string binary2) {
    string carry = "0"; // Initialize carry to false

    // Ensure both binary numbers have the same number of bits
    int maxLength = max(binary1.length(), binary2.length());
    binary1 = string(maxLength - binary1.length(), '0') + binary1;
    binary2 = string(maxLength - binary2.length(), '0') + binary2;

    // Iterate through each bit and check for carry
    for (int i = maxLength - 1; i >= 0; --i) {
        int sum = (binary1[i] - '0') + (binary2[i] - '0') + stoi(carry);
        if (sum > 1) {
            carry = "1"; // If sum is greater than 1, set carry to true
        } else {
            carry = "0"; // Otherwise, set carry to false
        }
    }

    return carry; // Return the final carry value
}

string zeroDetect(int num) {
    if (num == 0) {
        return "1"; // Return "1" if num is zero
    } else {
        return "0"; // Otherwise, return "0"
    }
}

void parseInstruction(const string& line, int& reg1, int& reg2, int& shiftAmt, string& funct, string& carry) {
    stringstream ss(line);
    string temp1, temp2, temp3;

    getline(ss, temp1, '_');
    reg1 = binaryToDecimal(temp1);
    cout << "reg1: " << temp1 << "  (" << reg1 << ")" << endl;
    getline(ss, temp2, '_');
    reg2 = binaryToDecimal(temp2);
    cout << "reg2: " << temp2 << "  (" << reg2 << ")" << endl;
    getline(ss, temp3, '_');
    shiftAmt = binaryToDecimal(temp3);
    cout << "shiftAmt: " << temp3 << "  (" << shiftAmt << ")" << endl;
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
    int reg1, reg2, shiftAmt;
    string time;
    string funct, carry;
    parseInstruction(instruction, reg1, reg2, shiftAmt, funct, carry);

    cout << "Funct: " << funct << endl;

    // Decode function
    string decodedFunct = decodeFunction(funct);

    // Perform ALU operation based on function
    int result;
    if (decodedFunct == "Add unsigned") {
        result = reg1 + reg2;
        cout << ">> Addu Result, reg1, reg2" << endl;
    } else if (decodedFunct == "Subtract unsigned") {
        result = reg1 - reg2;
        if(reg1 > reg2) {
            carry = "0";
        } else {
            carry = "1";
        }
        cout << ">> Subu Result, reg1, reg2" << endl;
    } else if (decodedFunct == "And") {
        result = reg1 & reg2;
        cout << ">> And Result, reg1, reg2" << endl;
    } else if (decodedFunct == "Shift right logical") {
        result = reg1 >> shiftAmt;
        cout << ">> Srl Result, reg1, shiftAmt" << endl;
    }
    cout << "result: " << result << endl;

    // Convert result to binary string
    string expectedOutput;
    for (int i = 31; i >= 0; --i) {
        expectedOutput += to_string((result >> i) & 1);
    }

    time = to_string(20 * lineNum);

    expectedOutput = time + "," + expectedOutput + "," + zeroDetect(result) + "," + carry;

    // Compare actual output with expected output
    if (expectedOutput != actualOutput) {
        cout << "Instruction: " << instruction << ", Function: " << decodedFunct << ", Output: " << actualOutput << endl;
        cout << "Expected: " << expectedOutput << " / Actual: " << actualOutput << endl;
        return false;
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
        int shiftAmt = rand() % 32;
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
        if (!testALU(instruction, output, lineNum)) {
            cerr << "Test failed at line " << lineNum << endl;
            cout << aluOutputFile.tellg() << endl; // Print the position of the file pointer
            return 1;
        }
        cout << "Test passed at line " << lineNum << endl;
        cout <<"------------------------------------" << endl;
        ++lineNum;
    }

    cout << "All tests passed!" << endl;

    // Close files
    aluInputFile.close();
    aluOutputFile.close();

    return 0;
}








