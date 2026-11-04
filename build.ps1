#!/usr/bin/env pwsh
<#
.SYNOPSIS
Build script for CyclopsDockingMod with Nautilus support

.PARAMETER Config
Build configuration (ReleaseNauti, ReleaseLegacy, Debug, DebugNauti, etc.)
Default: ReleaseNauti

.PARAMETER Action
Build action: build (default), clean, rebuild

.EXAMPLE
./build.ps1 -Config ReleaseNauti -Action build
./build.ps1 ReleaseNauti rebuild
#>

param(
    [string]$Config = "ReleaseNauti",
    [string]$Action = "build"
)

Write-Host "CyclopsDockingMod Build Script" -ForegroundColor Cyan
Write-Host "Configuration: $Config" -ForegroundColor Yellow
Write-Host "Action: $Action" -ForegroundColor Yellow
Write-Host ""

Push-Location source_repo

try {
    if ($Action -eq "clean" -or $Action -eq "rebuild") {
        Write-Host "Cleaning build artifacts..." -ForegroundColor Yellow
        dotnet clean -c $Config
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Warning: Clean encountered issues." -ForegroundColor Yellow
        }
    }

    if ($Action -eq "rebuild" -or $Action -eq "build") {
        if ($Action -eq "rebuild") {
            Write-Host "Rebuilding project..." -ForegroundColor Yellow
        } else {
            Write-Host "Building project..." -ForegroundColor Yellow
        }
        dotnet build -c $Config
    }

    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "==================================================" -ForegroundColor Green
        Write-Host "Build completed successfully!" -ForegroundColor Green
        Write-Host "Configuration: $Config" -ForegroundColor Green
        Write-Host "==================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Output location:" -ForegroundColor Cyan
        
        $outputPath = if ($Config -like "*Debug*") { "bin\Debug" } else { "bin\Release" }
        Write-Host "  $outputPath\CyclopsDockingMod.dll"
        Write-Host ""
        Write-Host "The DLL will be automatically copied to:" -ForegroundColor Cyan
        Write-Host "  C:\Program Files (x86)\Steam\steamapps\common\Subnautica\BepInEx\plugins\CyclopsDockingMod\"
        Write-Host "  (if the path is configured in the .csproj file)"
    } else {
        Write-Host ""
        Write-Host "==================================================" -ForegroundColor Red
        Write-Host "Build FAILED!" -ForegroundColor Red
        Write-Host "==================================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please check the error messages above." -ForegroundColor Red
        exit 1
    }
}
finally {
    Pop-Location
}
