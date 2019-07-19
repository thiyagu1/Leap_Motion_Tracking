@echo on

set LEAP_SDK_DIR=.\LeapSDK

cd %LEAP_SDK_DIR%\samples || exit /B 1
mkdir build
cd build || exit /B 1
cmake .. -G "Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX=install
cmake --build . --target "ALL_BUILD" --config "Release"

cd %~dp0
pause