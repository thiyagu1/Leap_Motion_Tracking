@echo off

set ROOT_DIR=%~dp0
set LEAP_CXX_BIN=%ROOT_DIR%LeapCxx*\build\bin\Release

FOR /F "tokens=*" %%g IN ('python -c "import sys,os; print(os.path.dirname(sys.executable))"') do (SET PYTHON_PATH=%%g)

echo Installing to %PYTHON_PATH%

cd %LEAP_CXX_BIN%
copy /B /Y Leap.py %PYTHON_PATH%\Lib\ || exit /B 1
copy /B /Y LeapPython.pyd %PYTHON_PATH%\DLLs\ || exit /B 1
copy /B /Y LeapC.dll %PYTHON_PATH%\DLLs\ || exit /B 1

python -c "import Leap"
echo done

cd %ROOT_DIR%
pause