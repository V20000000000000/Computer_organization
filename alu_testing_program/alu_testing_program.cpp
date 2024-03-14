#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

// Function prototypes
void parseInstruction(const string& line, int& reg1, int& reg2, int& shiftAmt, string& funct);
string decodeFunction(const string& funct);
bool testALU(const string& instruction, const string& expectedOutput, ifstream& aluOutputFile);

int main() {
    // Seed the random number generator
    srand(static_cast<unsigned int>(time(0)));

    // Generate ALUin.txt for the next test
    ofstream aluInput("ALUin.txt");
    if (!aluInput) {
        cerr << "Error: Unable to open ALUin.txt for writing!" << endl;
        return 1;
    }

    // Generate random test instructions
    const int numTests = 10;
    for (int i = 0; i < numTests; ++i) {
        int reg1 = rand() % 32;
        int reg2 = rand() % 32;
        int shiftAmt = rand() % 32;
        string funct;
        switch (rand() % 4) {
            case 0: funct = "001001"; break;
            case 1: funct = "001010"; break;
            case 2: funct = "010001"; break;
            case 3: funct = "100010"; break;
        }
        aluInput << reg1 << "_"
                 << reg2 << "_"
                 << shiftAmt << "_"
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
        if (!testALU(instruction, output, aluOutputFile)) {
            cerr << "Test failed at line " << lineNum << endl;
            cout << aluOutputFile.tellg() << endl; // Print the position of the file pointer
            return 1;
        }
        ++lineNum;
    }

    cout << "All tests passed!" << endl;

    // Close files
    aluInputFile.close();
    aluOutputFile.close();

    return 0;
}

void parseInstruction(const string& line, int& reg1, int& reg2, int& shiftAmt, string& funct) {
    stringstream ss(line);
    string temp;
    getline(ss, temp, '_');
    reg1 = stoi(temp);
    getline(ss, temp, '_');
    reg2 = stoi(temp);
    getline(ss, temp, '_');
    shiftAmt = stoi(temp);
    getline(ss, funct, '_');
}

string decodeFunction(const string& funct) {
    if (funct == "001001") return "Add unsigned";
    if (funct == "001010") return "Subtract unsigned";
    if (funct == "010001") return "And";
    if (funct == "100010") return "Shift right logical";
    return "Unknown";
}

bool testALU(const string& instruction, const string& expectedOutput, ifstream& aluOutputFile) {
    // Parse instruction
    int reg1, reg2, shiftAmt;
    string funct;
    parseInstruction(instruction, reg1, reg2, shiftAmt, funct);

    // Decode function
    string decodedFunct = decodeFunction(funct);

    // Perform ALU operation based on function
    int result;
    if (decodedFunct == "Add unsigned") {
        result = reg1 + reg2;
    } else if (decodedFunct == "Subtract unsigned") {
        result = reg1 - reg2;
    } else if (decodedFunct == "And") {
        result = reg1 & reg2;
    } else if (decodedFunct == "Shift right logical") {
        result = reg1 >> shiftAmt;
    }

    // Convert result to binary string
    string output;
    for (int i = 31; i >= 0; --i) {
        output += to_string((result >> i) & 1);
    }

    // Read actual output from ALU output file
    string line;
    getline(aluOutputFile, line);
    stringstream ss(line);
    string actualOutput;
    getline(ss, actualOutput, ',');  // Get the output value
    getline(ss, actualOutput, ',');  // Get the Carry_Flag
    getline(ss, actualOutput, ',');  // Get the Zero_Flag

    // Compare actual output with expected output
    if (output != actualOutput) {
        cout << "Instruction: " << instruction << ", Function: " << decodedFunct << ", Output: " << output << endl;
        cout << "Expected: " << expectedOutput << ", Actual: " << actualOutput << endl;
        return false;
    }

    return true;
}



