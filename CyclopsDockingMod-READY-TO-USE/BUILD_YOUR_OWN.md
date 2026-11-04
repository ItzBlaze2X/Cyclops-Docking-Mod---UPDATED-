# Build Your Own Fixed CyclopsDockingMod

The source code WITH THE FIX is ready to build. Follow these steps to create the DLL:

## Prerequisites

1. **Visual Studio 2022** (Community edition is free)
   - Download: https://visualstudio.microsoft.com/downloads/
   - Workload: ".NET desktop development"
   - Install: This includes MSBuild and .NET SDK

2. **Subnautica installed locally**
   - Required for BepInEx and Nautilus reference assemblies
   - Default path: `C:\Program Files (x86)\Steam\steamapps\common\Subnautica`

3. **BepInEx and Nautilus in Subnautica**
   - Your Subnautica installation should have these in `BepInEx/plugins/`

## Build Steps

### Option A: Using Visual Studio GUI (Easiest)

1. Open Visual Studio 2022
2. File → Open → Project/Solution
3. Navigate to: `source_repo\CyclopsDockingMod.sln`
4. In Solution Explorer, right-click the solution
5. Select Build → Solution Configuration → **ReleaseNauti**
6. Right-click again → Build Solution
7. Built DLL will be at: `source_repo\CyclopsDockingMod\bin\ReleaseNauti\CyclopsDockingMod.dll`

### Option B: Command Line (DevCmd)

1. Open Developer Command Prompt for Visual Studio 2022
2. Navigate to: `cd source_repo`
3. Run:
   ```
   msbuild CyclopsDockingMod.sln /p:Configuration=ReleaseNauti /p:Platform="Any CPU"
   ```
4. Built DLL will be at: `source_repo\CyclopsDockingMod\bin\ReleaseNauti\CyclopsDockingMod.dll`

## Copy to Ready-to-Use Folder

After building:

```
Copy: source_repo\CyclopsDockingMod\bin\ReleaseNauti\CyclopsDockingMod.dll
To:   CyclopsDockingMod-READY-TO-USE\BepInEx\plugins\CyclopsDockingMod\
```

Then your mod is ready to install!

## The Fix (What Changed)

File: `source_repo\CyclopsDockingMod\CyclopsHatchConnector.cs`

**Before:**
```csharp
#if SUBNAUTICA_NAUTI
using Nautilus.Crafting;
#else
using SMLHelper.V2.Crafting;
#endif
using Ingredient = CraftData.Ingredient;  // ← WAS HERE (global scope)
```

**After:**
```csharp
#if SUBNAUTICA_NAUTI
using Nautilus.Crafting;
#else
using SMLHelper.V2.Crafting;
using Ingredient = CraftData.Ingredient;  // ← NOW HERE (SMLHelper only)
#endif
```

This ensures the Nautilus build uses the correct `Nautilus.Crafting.Ingredient` type.

## Troubleshooting

**"assembly not found" warnings**: Normal if you don't have Subnautica locally. DLL still builds.

**Build fails completely**: Make sure you have:
- [ ] Visual Studio 2022 with .NET workload
- [ ] Subnautica installed at default path
- [ ] BepInEx + Nautilus in your Subnautica folder

**Need help?** The source code is ready—just open it in Visual Studio and build.
