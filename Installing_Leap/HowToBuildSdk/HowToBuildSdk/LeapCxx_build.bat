@echo on

set ROOT_DIR=%~dp0
set LEAP_SDK_DIR=%ROOT_DIR%LeapSDK\lib\cmake\LeapSDK
set LEAP_CXX_DIR=%ROOT_DIR%LeapCxx
set SWIG_EXE=%ROOT_DIR%swigwin-3.0.12\swig.exe

cd %LEAP_CXX_DIR%* || exit /B 1
mkdir build
cd build || exit /B 1

cmake .. -G "Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX=install -DLeapSDK_DIR=%LEAP_SDK_DIR% -DBUILD_SWIG=ON -DSWIG_EXECUTABLE=%SWIG_EXE%  -DUseSWIG_TARGET_NAME_PREFERENCE=STANDARD || exit /B 1

cmake --build . --target "ALL_BUILD" --config "Debug" || exit /B 1
cmake --build . --target "INSTALL" --config "Debug" || exit /B 1
move /Y "install\lib\LeapC++.lib" "install\lib\LeapC++d.lib" || exit /B 1

cmake --build . --target "ALL_BUILD" --config "Release" || exit /B 1
cmake --build . --target "INSTALL" --config "Release" || exit /B 1
copy /B /Y bin\Release\_LeapPython.pyd bin\Release\LeapPython.pyd || exit /B 1

echo. 
echo Python module: \build\bin\Release
echo Install folder: \build\install

cd %ROOT_DIR%
pause