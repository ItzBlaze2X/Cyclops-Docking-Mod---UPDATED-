@echo off
REM Build script for CyclopsDockingMod with Nautilus 1.0.0.53 fix
REM This will compile the fixed source code into a DLL

set BASEDIR=%~dp0
set PROJECTDIR=%BASEDIR%source_repo
set OUTDIR=%BASEDIR%CyclopsDockingMod-READY-TO-USE\BepInEx\plugins\CyclopsDockingMod

echo ============================================================
echo Building CyclopsDockingMod (ReleaseNauti Configuration)
echo ============================================================
echo.

cd /d "%PROJECTDIR%"

REM Find and run VS2018 Build Tools
set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\MSBuild\Current\Bin\amd64\MSBuild.exe"
set "VCVARS=C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"

if exist "%VCVARS%" (
    echo Setting up Visual Studio environment...
    call "%VCVARS%" >nul 2>&1
) else (
    echo WARNING: vcvars not found, continuing anyway...
)

if exist "%MSBUILD%" (
    echo Running MSBuild...
    "%MSBUILD%" CyclopsDockingMod.sln /p:Configuration=ReleaseNauti /p:Platform="Any CPU" /m:4
) else (
    echo ERROR: MSBuild not found at %MSBUILD%
    exit /b 1
)

echo.
echo Checking for built DLL...

set "DLL=%PROJECTDIR%\CyclopsDockingMod\bin\ReleaseNauti\CyclopsDockingMod.dll"

if exist "%DLL%" (
    echo.
    echo BUILD SUCCESSFUL!
    echo Source: %DLL%
    echo.
    echo Copying to ready-to-use folder...
    copy "%DLL%" "%OUTDIR%\CyclopsDockingMod.dll"
    echo.
    echo DONE! Your mod is ready at:
    echo %OUTDIR%
    echo.
) else (
    echo ERROR: DLL not found at %DLL%
    echo Build may have failed - check output above
    exit /b 1
)
