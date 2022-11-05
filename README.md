# 在MATLAB中对批量C/C++文件进行mex文件编译

- date: 2018.8.3
- author: cuixngxing
- 功能等同于写CMakeLists.txt

示例使用`OpenCV` C++库来对存储在xml中的矩阵进行读取，读取/返回结果存储为matlab中double类型的数组，getMat函数就像内置函数一样使用。
