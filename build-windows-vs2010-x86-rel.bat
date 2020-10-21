mkdir .\Build\vs2010-x86
cd .\Build\vs2010-x86
cmake -A Win32 ..\..\src -G"Visual Studio 16 2019" || goto :error
cmake --build . --config Debug || goto :error
cd ..\..

mkdir .\Build\vs2010-x86-tests
cd .\Build\vs2010-x86-tests
cmake -A Win32 ..\..\tests -G"Visual Studio 16 2019" || goto :error
cmake --build . --config Debug || goto :error
cd ..\..

python run_tests.py Build/vs2010-x86-tests/Debug || goto :error
goto :EOF

:error
echo Failed with error %errorlevel%.
exit /b %errorlevel%