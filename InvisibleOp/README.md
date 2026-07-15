# InvisibleOp v1.1 — Operator & Boss Invisibility Mod

Arknights: Endfield shader-hunting mod. Skips GPU draw calls for operators, bosses, icons, and VFX using EFMI (3dmigoto-based). 131 hunted shader hashes across 6 categories.

> **Current compatibility:** Only tested with operator **洛茜 (Rossi)** and boss **罗丹 (Rhodagn)**. Other characters may not be fully covered. Contributions welcome for additional character hashes.

## How It Works

EFMI intercepts DirectX draw calls. When a shader hash matches, `handling = skip` tells the GPU: "don't draw this." Each character uses multiple materials — body, hair, weapon, shadow, VFX — each needing its own hash.

## Toggle Keys

| Key | Action |
|-----|--------|
| **F1** | Master toggle — hide everything (operators, bosses, icons, VFX) |
| **F2** | Toggle operators only (body + weapon + shadow + VFX) |
| **F3** | Toggle bosses only (body + shadow + skill VFX) |
| **F10** | Reload all mods |

## Shader Categories (131 total)

| Category | Count | Toggle | Description |
|----------|-------|--------|-------------|
| Icons | 4 | F1 | Enemy markers, health bars, level indicators |
| Operators | 32 | F2 | Body, hair, face, weapon, shadow |
| Operator VFX | 44 | F2 | Skill effects, particles, auras |
| Boss Base | 29 | F3 | Boss body materials |
| Boss Shadow | 1 | F3 | Boss shadow (VS match) |
| Boss Skill VFX | 21 | F3 | Boss skill effects, energy waves |

## Shader Hunting Guide

### Controls

| Key | Action |
|-----|--------|
| **Home** | Enter/exit shader hunting mode |
| **]** / **[** | Cycle pixel shaders (PS) |
| **\\** | Mark PS hash → clipboard |
| **F6** / **F5** | Cycle vertex shaders (VS) |
| **F7** | Mark VS hash → clipboard |
| **Ctrl+]** / **Ctrl+[** | Cycle index buffers |
| **End** | Switch marking mode |
| **Insert** | Done hunting (restore all hidden) |
| **Shift+F11** | Frame analysis dump (entire frame) |

### Step-by-Step: Hunt a Shader

1. Press **Home** — green overlay appears top-left
2. Press **]** to cycle PS hashes, watch the target
3. When target flickers/disappears → press **\\** to copy hash
4. Paste hash into `mod.ini` in the right section
5. F10 to reload, test

### PS vs VS: Which to Use?

| | Pixel Shader (PS) | Vertex Shader (VS) |
|---|---|---|
| **Use when** | Default. Works for 90%+ | Body part still visible after all PS hashes |
| **How to hunt** | ] / [ | F6 / F5 |
| **INI setting** | `Hash = ...` (default) | `Hash = ...` + `match_type = vs` |
| **Risk** | Low. One shader = one material | Higher. May hide unintended objects |

### Frame Analysis: Catch Transient Effects

Skill casts, brief VFX, and shadow shaders that appear too fast to hunt manually:

1. **Idle frame**: boss/operator idle → press **Shift+F11**
2. **Skill frame**: during skill/VFX animation → press **Shift+F11**
3. Run diff tool:
   ```
   powershell .\diff_frames.ps1
   ```
4. Script outputs mod.ini-ready entries for hashes only in the skill frame
5. Add to mod.ini, F10 reload, test

### Pro Tips

- **Disable all other mods** before hunting — other mod overlays interfere
- **Hunt in open world**, not character menu (LOD variants differ)
- **Walk away** to trigger LOD changes, hunt lower-detail variants too
- **Hunt on your usual graphics settings** — High/Medium/Low use different shader variants
- **Test on multiple maps** — some shaders are per-level
- **Paste hashes immediately** — overlay disappears on alt-tab

## Installation

1. Copy `InvisibleOp` folder into:
   ```
   <EFMI directory>\Mods\InvisibleOp\
   ```
   Typically: `%APPDATA%\XXMI Launcher\EFMI\Mods\InvisibleOp\`
2. Launch game through XXMI Launcher (EFMI enabled)
3. In-game, press **F10** to load

## File Structure

```
InvisibleOp/
├── mod.ini           ← Shader overrides (hunted hashes go here)
├── diff_frames.ps1   ← Frame analysis diff tool
└── README.md         ← This file
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Mod doesn't load (F10 nothing) | Check XXMI Launcher → EFMI enabled |
| Character partially visible | Missed a shader. Hunt face/eyes/hair-tips separately. Try VS (F6) |
| Floating eyes/teeth | Face shader appears late in cycle — keep pressing ] |
| Environment objects disappearing | Remove that hash. Too broad. Try VS match instead |
| F1 doesn't hide everything | Check mod.ini → [Constants] has blank line before next section |
| Hunting overlay shows nothing | Face camera at character. Restart game if persistent |
| Game crashes on F10 | Syntax error in mod.ini — check missing `endif`, duplicate section names |
| Mod stops working after game update | Shader hashes changed. Re-hunt |
| VS cycling doesn't work (Shift+[ ]) | Use F5/F6/F7 instead — changed in d3dx.ini |

## Ban Risk

This mod uses EFMI runtime injection. Arknights: Endfield uses ACE kernel-level anti-cheat. **Ban risk is real.**

- Do NOT use on main account
- Disable during any multiplayer/co-op content
- Do not post modded screenshots tied to your account

## Credits

Built with EFMI (3dmigoto for Endfield): https://github.com/SpectrumQT/EFMI-Tools
