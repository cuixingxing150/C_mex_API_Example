#include "opencv2/opencv.hpp"
#include <iostream>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    if ((nrhs != 1) && (nlhs != 1)) {
        mexErrMsgIdAndTxt("参数错误:",
                          "输入参数和输出参数个数必须为1");
    }
    if (!mxIsChar(prhs[0])) {
        mexErrMsgIdAndTxt("输入参数错误:", "输入参数必须为字符类型");
    }
    char *input_buf;
    input_buf = mxArrayToString(prhs[0]);  //使用mxArrayToString将mxArray转换为c、c++字符串
    std::string xmlname = input_buf;
    cv::FileStorage fs(xmlname, cv::FileStorage::READ);
    cv::Mat currentFolderFeatures;
    fs["currentFolderFeatures"] >> currentFolderFeatures;  // ！这里xml里面变量改成属于自己名字
    if (!currentFolderFeatures.data) {
        mexPrintf("输入参数xml必须是全路径的xml!");
        mexErrMsgIdAndTxt("输入参数错误:", "输入参数xml必须是全路径的xml!");
        return;
    }

    // 转换Mat
    int m = currentFolderFeatures.rows;
    int n = currentFolderFeatures.cols;
    plhs[0] = mxCreateDoubleMatrix(m, n, mxREAL);
    double *imgMat;
    imgMat = mxGetPr(plhs[0]);
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            *(imgMat + i + j * m) = (double)currentFolderFeatures.at<float>(i, j);
        }
    }
}
