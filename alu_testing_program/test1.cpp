#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

// 函數用來移除字符串中的空格
void removeSpaces(std::string &str) {
    str.erase(std::remove_if(str.begin(), str.end(), ::isspace), str.end());
}

int main() {
    // 打開文件
    std::ifstream file("tb_ALU.out");

    // 檢查文件是否成功打開
    if (!file.is_open()) {
        std::cerr << "無法打開文件" << std::endl;
        return 1;
    }

    std::string line;
    // 讀取每一行，並且移除空格
    while (std::getline(file, line)) {
        removeSpaces(line);
        // 輸出沒有空格的行
        std::cout << line << std::endl;
    }

    // 關閉文件
    file.close();

    return 0;
}
