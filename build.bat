@echo off
REM Build script for CyclopsDockingMod with Nautilus support
REM Usage: build.bat [config] [action]
REM   config: ReleaseNauti (default), ReleaseLegacy, Debug, DebugNauti, etc.
REM   action: build (default), clean, rebuild

setlocal enabledelayedexpansion

set CONFIG=%1
if "!CONFIG!"=="" set CONFIG=ReleaseNauti

set ACTION=%2
if "!ACTION!"=="" set ACTION=build

echo CyclopsDockingMod Build Script
echo Configuration: !CONFIG!
echo Action: !ACTION!
echo.

cd source_repo

if /i "!ACTION!"=="clean" (
    echo Cleaning build artifacts...
    dotnet clean -c !CONFIG! >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        echo Clean completed successfully.
    ) else (
        echo Warning: Clean encountered issues.
    )
)

if /i "!ACTION!"=="rebuild" (
    echo Rebuilding project...
    dotnet clean -c !CONFIG! >nul 2>&1
    dotnet build -c !CONFIG!
) else (
    echo Building project...
    dotnet build -c !CONFIG!
)

if !ERRORLEVEL! equ 0 (
    echo.
    echo ==================================================
    echo Build completed successfully!
    echo Configuration: !CONFIG!
    echo ==================================================
    echo.
    echo Output location:
    echo   bin\Release\CyclopsDockingMod.dll (or bin\Debug\ for Debug config)
    echo.
    echo The DLL will be automatically copied to:
    echo   C:\Program Files (x86)\Steam\steamapps\common\Subnautica\BepInEx\plugins\CyclopsDockingMod\
    echo (if the path is configured in the .csproj file)
) else (
    echo.
    echo ==================================================
    echo Build FAILED!
    echo ==================================================
    echo.
    echo Please check the error messages above.
    pause
    exit /b 1
)

cd ..

pause
