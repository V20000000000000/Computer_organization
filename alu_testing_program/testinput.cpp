#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main() {
    // 打开文件
    ifstream inputFile("tb_ALU.out");

    // 检查文件是否成功打开
    if (!inputFile) {
        cerr << "无法打开文件" << endl;
        return 1;
    }

    // 读取文件内容并输出
    string line;
    while (getline(inputFile, line)) {
        cout << line << endl;
    }

    // 关闭文件
    inputFile.close();

    return 0;
}
