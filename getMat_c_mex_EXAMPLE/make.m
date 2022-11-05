% Notice: first use "mex -setup" to choose your c/c++ compiler  
clear;  
  
%% -------------------------------------------------------------------  
%% get the architecture of this computer  
is_64bit = strcmp(computer,'MACI64') || strcmp(computer,'GLNXA64') || strcmp(computer,'PCWIN64');  
  
  
%% -------------------------------------------------------------------  
%% the configuration of compiler  
% You need to modify this configuration according to your own path of OpenCV  
% 注意：你的VS OpenCV平台一定要匹配Matlab 64位的！  
out_dir='./';% 当前目录  
CPPFLAGS = ' -g -IE:\opencv3_4_2\opencv\build\include -IE:\opencv3_4_2\opencv\build\include\opencv -IE:\opencv3_4_2\opencv\build\include\opencv2'; % your OpenCV "include" path  
LDFLAGS = ' -LE:\opencv3_4_2\opencv\build\x64\vc14\lib'; % 用OpenCV release版本的"lib"路径  
LIBS = ' -lopencv_world342'; % release版本的lib，无后缀，系统会自动加上去  
% mingw64编译器参考：https://ww2.mathworks.cn/matlabcentral/answers/1807390-how-can-i-compile-and-link-static-libraries-from-the-mingw64-compiler-on-a-windows-system-using-the
if is_64bit  
    CPPFLAGS = [CPPFLAGS ' -largeArrayDims'];  
end  
%% add your files here!  
compile_files = [  
    % the list of your code files which need to be compiled  
    'getMat.cpp'
    ];  
%-------------------------------------------------------------------  
%% compiling...  
str = compile_files;  
fprintf('compilation of: %s\n', str);  
str = [str ' -outdir ' out_dir CPPFLAGS LDFLAGS LIBS];  
args = regexp(str, '\s+', 'split');  
mex(args{:});  
  
fprintf('Congratulations, compilation successful!!!\n');  
