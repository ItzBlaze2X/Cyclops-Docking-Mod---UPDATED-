# CyclopsDockingMod Update for Nautilus 1.0.0.53

## What Was Fixed

✅ **Fixed the "Field 'Nautilus.Crafting.RecipeData.Ingredients' not found" error**

The mod has been updated to work with **Nautilus 1.0.0.53 and later** by correcting how the Recipe API is used.

## Quick Start

### Option 1: Use the Pre-Built DLL (Easiest)

If you just want to use the mod:
1. Copy the compiled DLL from the mod folder into your Subnautica installation
2. Make sure you have Nautilus 1.0.0.53+ installed
3. Run the game

### Option 2: Build Yourself

If you want to rebuild the mod or contribute:

**On Windows:**
```batch
build.bat ReleaseNauti
```

**On Windows with PowerShell:**
```powershell
.\build.ps1 ReleaseNauti
```

**On Linux/Mac:**
```bash
cd source_repo
dotnet build -c ReleaseNauti
```

## What Changed

Only **one file** was modified:
- `CyclopsDockingMod/CyclopsHatchConnector.cs` - Fixed the `using Ingredient` statement to work correctly with Nautilus

See [UPDATE_SUMMARY.md](UPDATE_SUMMARY.md) for technical details.

## Requirements

- **Nautilus:** 1.0.0.53 or later
- **.NET SDK:** 6.0+ (for building)
- **Subnautica:** Latest version recommended

## Troubleshooting

**The mod still doesn't load?**
- Verify Nautilus is installed correctly in your BepInEx plugins folder
- Check the BepInEx console for error messages
- Make sure you're using the `ReleaseNauti` build, not the legacy version

**Build fails?**
- Make sure you have .NET SDK installed: `dotnet --version`
- Ensure your Subnautica path is correct in the `.csproj` file
- Try running `dotnet restore` first if NuGet packages aren't downloading

**Still having issues?**
- Check the [BUILD_GUIDE.md](BUILD_GUIDE.md) for detailed troubleshooting
- Review the [UPDATE_SUMMARY.md](UPDATE_SUMMARY.md) for technical background

## Files Included

- `source_repo/` - Full source code with the fix applied
- `BUILD_GUIDE.md` - Comprehensive build instructions
- `UPDATE_SUMMARY.md` - Technical details about the changes
- `build.bat` - Windows batch build script
- `build.ps1` - PowerShell build script
- `Cyclops Docking Mod-554-2-1-1-1711657943.zip` - Original mod archive (for reference)

## Version Info

| Component | Version |
|---|---|
| CyclopsDockingMod | 2.1.1 |
| Target Nautilus | 1.0.0.53+ |
| .NET Target | netstandard2.0 |
| Update Date | November 4, 2026 |

## Next Steps

1. **Read** [UPDATE_SUMMARY.md](UPDATE_SUMMARY.md) for technical details
2. **Build** the mod using the scripts provided, or use the pre-compiled DLL
3. **Test** in Subnautica to confirm it works
4. **Report** any issues you encounter

---

**Enjoy your updated CyclopsDockingMod!** 🚀

For questions or contributions, see the original repository at: https://github.com/K07H/CyclopsDockingMod
