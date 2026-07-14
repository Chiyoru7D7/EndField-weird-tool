# InvisibleOp — Operator & Boss Invisibility Mod

Arknights: Endfield shader-hunting mod. Skips GPU draw calls for playable characters and bosses using EFMI (3dmigoto-based). No model editing, no Blender needed.

## How It Works

EFMI intercepts DirectX draw calls. When a shader hash matches, `handling = skip` tells the GPU: "don't draw this object." Each character is made of multiple materials (body, hair, weapon, outline, shadow) — each needs its own shader hash.

## Installation

1. Copy the `InvisibleOp` folder into:
   ```
   <EFMI directory>\Mods\InvisibleOp\
   ```
   Typically: `%APPDATA%\XXMI Launcher\EFMI\Mods\InvisibleOp\`
2. Launch game through XXMI Launcher (EFMI must be enabled in Settings)
3. In-game, press **F10** to load the mod

## Toggle Keys

| Key | Action |
|-----|--------|
| **F1** | Master toggle — all invisibility on/off |
| **F2** | Toggle operators/playable characters only |
| **F3** | Toggle bosses/named enemies only |
| **F10** | Reload all mods (after editing files) |

## Shader Hunting Guide

### Prerequisites

- XXMI Launcher + EFMI installed and enabled
- Resolution: 1920×1080 recommended (smaller frame dumps)
- **Disable all other mods** — temporarily rename `Mods` folder if needed. The character you're hunting must have NO mods applied.

### Hunting Controls

| Key | Action |
|-----|--------|
| **Home** | Enter/exit Shader Hunting mode (green overlay) |
| **[** / **]** | Cycle previous/next **pixel shader** (PS) |
| **\\** | Mark shader — copy hash to clipboard |
| **Shift+[** / **Shift+]** | Cycle **vertex shader** (VS) |
| **Ctrl+[** / **Ctrl+]** | Cycle **index buffer** |
| **End** | Switch marking mode (pink → green → blue) |
| **Insert** | Done hunting — restore all hidden shaders |

If Home/End/Insert conflict with game keybinds, edit `<EFMI>/d3dx.ini` → search for `toggle_hunting` / `next_marking_mode` / `done_hunting`. Full key code reference: https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes

### Step-by-Step: Hunt Operator Shaders

1. **Enter hunting mode.** Press **Home**. Green overlay text appears top-left showing current shader info.

2. **Find a target.** Stand near an operator in open world. Make sure they're fully visible on screen.

3. **Cycle pixel shaders.** Press **]** to advance through shaders. Each press hides a different shader group. Watch the operator carefully.

4. **When a body part flickers or disappears:**
   - Press **\\** to copy the PS hash to clipboard
   - Open `mod.ini` in Notepad
   - Find the matching section (body, hair, weapon, etc.)
   - Replace the placeholder with the hash: `hash = a1b2c3d4` (lowercase, no `0x`)
   - Note in a comment what disappeared: `; → hides left arm`

5. **Keep cycling.** A typical operator needs 4-8 shaders:
   - Body/skin (1-2 hashes)
   - Hair (1-2 hashes)
   - Face/eyes (1-2 hashes)
   - Weapon/equipment (1-3 hashes)
   - Outline/rim light (1 hash)
   - Shadow (1 hash)

6. **Verify full invisibility.** Press Insert to restore all shaders, then F10 to reload. Press F1 — operator should be fully gone.

### Step-by-Step: Hunt Boss Shaders

1. Find a boss in open world (named/elite enemy)
2. Press Home, cycle pixel shaders with [ / ]
3. Bosses often have **dedicated VFX layers** (auras, energy glows, particle trails) — hunt while the effect is active
4. Watch for environment objects disappearing — if rocks/vfx vanish, that hash is too broad, remove it
5. Fill in BOSS_* placeholders in mod.ini

### PS vs VS: Which to Use?

| | Pixel Shader (PS) | Vertex Shader (VS) |
|---|---|---|
| **Specificity** | More specific — safer | Broader — catches more |
| **Use when** | Default. Works for 90%+ of materials | Body part still visible after all PS hashes filled |
| **How to hunt** | [ / ] | Shift+[ / Shift+] |
| **match_type** | `match_type = ps` (or omit — it's default) | `match_type = vs` (REQUIRED) |
| **Risk** | Low. One shader = one material type | Higher. May hide unintended objects |

### Index Buffer Fallback (Last Resort)

If shader hash matching doesn't work (game reuses shaders across many objects), use vertex count matching:

1. Press **Ctrl+[** / **Ctrl+]** to cycle index buffers
2. The overlay shows `IndexCount: N`
3. Note the count range of the character's draw calls
4. Uncomment the `[TextureOverrideOpByIndex]` section in mod.ini
5. Set a **narrow range** (e.g. `5000, 15000`)

**Warning:** This is the broadest matching method. It WILL hide anything in that vertex count range — including environment props. Use as narrow a range as possible.

## Pro Tips

- **Hunt in open world**, not character menu. Menu uses high-detail models; open world uses LOD variants with possibly different shaders.
- **Walk away from the character** to trigger LOD changes, then hunt again. Different LOD levels may use different shader hashes.
- **Hunt on your usual graphics settings.** High/Medium/Low presets often use different shader variants. Hunt on whatever you normally play on.
- **Test on multiple maps.** Some shaders are loaded per-level and may differ between areas.
- **Restart the game fresh** before hunting. Lingering shader states from previous gameplay can confuse the overlay.
- **Mark shaders as you find them.** Don't try to memorize hashes — paste into mod.ini immediately. Overlay disappears when you alt-tab.

## Troubleshooting

| Problem | Likely Cause | Fix |
|----------|-------------|-----|
| Mod doesn't load (F10 does nothing) | EFMI not enabled | Check XXMI Launcher → Settings → EFMI enabled |
| Character partially visible after all hashes | Missed a shader | Hunt face/eyes/hair-tips/accessories separately. Walk away to trigger LOD switch, hunt again |
| Floating eyes/teeth | Face shader not captured | Cycle past body/hair — face shader often appears LATE in the cycle |
| Environment objects disappearing | Hash too broad (shared with props) | Remove that hash. Try VS matching instead, or use index buffer range |
| "Green overlay shows nothing" | No draw calls on screen | Face the camera at a character. If still blank, restart game |
| Game crashes on F10 | Syntax error in mod.ini | Check for: missing `endif`, duplicate `[section]` names, `match_type = vs` without a hash |
| Mod works then stops working | Game updated, shader hashes changed | Re-hunt all hashes. This is normal — every game patch may change shader compilation |
| Home key does nothing | hunting = 0 in d3dx.ini | Open d3dx.ini, set `hunting = 2` under `[Hunting]` section |

## File Structure

```
InvisibleOp/
├── mod.ini       ← Shader overrides (edit this with hunted hashes)
└── README.md     ← This file
```

No textures, no models, no shader binaries. Pure INI configuration.

## Ban Risk

This mod uses EFMI runtime injection. Arknights: Endfield uses ACE kernel-level anti-cheat. **Ban risk is real.** See [[endfield-mod-ban-risk]] for full assessment.

- Do NOT use on main account
- Disable during any multiplayer/co-op content
- Do not post modded screenshots tied to your account

## Credits

Built with EFMI (3dmigoto for Endfield): https://github.com/SpectrumQT/EFMI-Tools
