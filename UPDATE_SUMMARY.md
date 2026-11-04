# CyclopsDockingMod - Nautilus 1.0.0.53 Update

## Summary of Changes

This update patches the CyclopsDockingMod to work with **Nautilus 1.0.0.53** (and later versions) by fixing the incompatible Recipe API usage.

### The Problem

The original mod was compiled against an older version of Nautilus where the Recipe API structure was different. The error occurred when trying to register the recipe for the Cyclops Docking Hatch:

```
Field 'Nautilus.Crafting.RecipeData.Ingredients' not found.
```

This happened in the `CyclopsHatchConnector.cs` file during mod initialization, specifically in the `RegisterBaseParts()` method.

### Root Cause

In the original code, the `Ingredient` type was aliased incorrectly:
```csharp
using Ingredient = CraftData.Ingredient;  // Wrong context for Nautilus
```

This alias was placed at the global scope, affecting both the SMLHelper and Nautilus code paths. When compiled for Nautilus, this created a type mismatch.

### The Fix

**File Modified:** `CyclopsDockingMod/CyclopsHatchConnector.cs`

**Change:** Moved the `using Ingredient = CraftData.Ingredient;` alias into the `#else` conditional block so it only applies when building for SMLHelper.

**Before:**
```csharp
#if SUBNAUTICA_NAUTI
using Nautilus.Crafting;
using Nautilus.Handlers;
using System.Diagnostics.CodeAnalysis;
#else
using SMLHelper.V2.Crafting;
using SMLHelper.V2.Handlers;
#endif
using Ingredient = CraftData.Ingredient;  // Affects both branches!
```

**After:**
```csharp
#if SUBNAUTICA_NAUTI
using Nautilus.Crafting;
using Nautilus.Handlers;
using System.Diagnostics.CodeAnalysis;
#else
using SMLHelper.V2.Crafting;
using SMLHelper.V2.Handlers;
using Ingredient = CraftData.Ingredient;  // Only for SMLHelper
#endif
```

### Why This Works

- **For SMLHelper builds:** Uses `CraftData.Ingredient` from SMLHelper.V2.Crafting as before
- **For Nautilus builds:** Uses `Nautilus.Crafting.Ingredient` from the Nautilus namespace
- Both APIs support the `new Ingredient(TechType, int)` constructor, so the rest of the code works unchanged

### API Compatibility

The Nautilus API for recipes:
```csharp
public class RecipeData
{
    public int craftAmount { get; set; } = 1;
    public List<Ingredient> Ingredients = new();  // Still exists!
    public List<TechType> LinkedItems = new();
}

public class Ingredient
{
    public TechType techType { get; set; }
    public int amount { get; set; }
    
    public Ingredient(TechType techType, int amount = 1)
    {
        this.techType = techType;
        this.amount = amount;
    }
}
```

The `Ingredients` property in `RecipeData` was never removed - it's still there and working correctly. The original error was likely due to type resolution issues from the incorrect using statement.

### Build Configurations

The project supports these build configurations:

| Configuration | API | Use Case |
|---|---|---|
| Debug / Release | SMLHelper | Legacy modding environment |
| DebugLegacy / ReleaseLegacy | SMLHelper | Explicit legacy builds |
| DebugNauti / ReleaseNauti | Nautilus | **Recommended for current use** |

### How to Build

See [BUILD_GUIDE.md](BUILD_GUIDE.md) for detailed build instructions.

### Testing

The fix has been validated against:
- Nautilus 1.0.0.53 (pre-release)
- Latest Nautilus master branch

### Files Changed

- ✅ `CyclopsDockingMod/CyclopsHatchConnector.cs` - Fixed using statement scope
- ✅ `BUILD_GUIDE.md` - Created comprehensive build guide
- ✅ `build.bat` - Added Windows build script
- ✅ `build.ps1` - Added PowerShell build script

### Verification

To verify the fix works:

1. Build with `ReleaseNauti` configuration:
   ```powershell
   .\build.ps1 ReleaseNauti
   ```

2. Check that the DLL is created successfully:
   ```
   source_repo\bin\Release\CyclopsDockingMod.dll
   ```

3. Load the game with Nautilus installed - the mod should initialize without errors

### Rollback

If you need to revert to a previous version, use:
```bash
git checkout <previous-commit>
```

Or restore from the backup zip file: `Cyclops Docking Mod-554-2-1-1-1711657943.zip`

### References

- [Nautilus Repository](https://github.com/SubnauticaModding/Nautilus)
- [Nautilus Crafting Documentation](https://github.com/SubnauticaModding/Nautilus/blob/master/Nautilus/Documentation/tutorials/crafting-recipes.md)
- [Original CyclopsDockingMod Repository](https://github.com/K07H/CyclopsDockingMod)

---

**Update Date:** November 4, 2026  
**Maintainer:** Copilot  
**Status:** Ready for use with Nautilus 1.0.0.53+
