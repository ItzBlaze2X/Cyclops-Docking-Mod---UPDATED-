# CyclopsDockingMod Update Guide

## Problem
The CyclopsDockingMod was compiled against an older version of Nautilus that used a different Recipe API. The current build fails with:
```
Field 'Nautilus.Crafting.RecipeData.Ingredients' not found.
```

## Solution
This build has been updated to support Nautilus 1.0.0.53+ with the following changes:

### Changes Made

1. **Updated CyclopsHatchConnector.cs**
   - Fixed the conditional import of the `Ingredient` type to properly handle both SMLHelper and Nautilus versions
   - The alias `using Ingredient = CraftData.Ingredient` is now only applied in the SMLHelper (#else) branch
   - Both APIs now correctly create `Ingredient` objects with the (TechType, int) constructor

2. **Build Configurations**
   - The project supports multiple configurations:
     - `Debug/Release`: Legacy SMLHelper version
     - `DebugLegacy/ReleaseLegacy`: Legacy SMLHelper version (explicit)
     - `DebugNauti/ReleaseNauti`: Nautilus version (recommended for current use)

### How to Build

#### Requirements
- .NET SDK (6.0 or newer)
- Subnautica game directory with BepInEx installed
- Nautilus mod installed in BepInEx/plugins/Nautilus/

#### Build Steps

##### Option 1: Using Visual Studio
1. Open `source_repo/CyclopsDockingMod.sln`
2. Select the configuration `ReleaseNauti` from the dropdown
3. Build the solution
4. The compiled DLL will be copied to your Subnautica BepInEx plugins directory

##### Option 2: Using Command Line
```bash
cd source_repo
dotnet build -c ReleaseNauti
```

#### Configuration
Edit the .csproj file to set your Subnautica installation directory if it's not at the default location:
```
<SubnauticaDir>C:\Program Files (x86)\Steam\steamapps\common\Subnautica</SubnauticaDir>
```

### Troubleshooting

**Error: "BepInEx\core\BepInEx.dll not found"**
- Make sure you have BepInEx installed in your Subnautica directory
- Update the `SubnauticaDir` path in the .csproj file

**Error: "BepInEx\plugins\Nautilus\Nautilus.dll not found"**
- Make sure Nautilus is installed via the BepInEx plugin manager or manually placed in BepInEx/plugins/Nautilus/
- Alternatively, the build can be updated to use NuGet package references

**The mod doesn't load in-game**
- Ensure you compiled with the `ReleaseNauti` configuration
- Verify the resulting DLL is in `Subnautica\BepInEx\plugins\CyclopsDockingMod\CyclopsDockingMod.dll`
- Check the BepInEx console for error messages

### Version Compatibility
- **Nautilus**: 1.0.0.53 and later
- **.NET Target**: netstandard2.0 (works with Subnautica's managed assemblies)
- **Subnautica**: Tested with recent updates

### Files Modified
- `CyclopsDockingMod/CyclopsHatchConnector.cs`: Fixed `Ingredient` type handling for Nautilus API
