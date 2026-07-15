# EndField Weird Tool

[中文版](README_CN.md) | English

EFMI/3dmigoto shader-hunting mods for Arknights: Endfield. Weird tools for weird needs.

## Tools

### [InvisibleOp](InvisibleOp/)

Hide operators, bosses, icons, and VFX by skipping GPU draw calls. 131 hunted shader hashes across 6 categories.

- F1 master toggle, F2 operators, F3 bosses
- Frame analysis diff tool for catching transient skill VFX
- PS and VS shader hunting support

## Shader Hunting Stack

These tools all build on the same foundation. Understanding one helps with the rest.

| Component | Description |
|-----------|-------------|
| **EFMI** | 3dmigoto fork for Endfield. DLL injection, shader override engine |
| **XXMI Launcher** | Mod manager. Handles EFMI injection, mod loading, per-game profiles |
| **d3dx.ini** | Global EFMI config. Hunting keybinds, frame analysis settings |
| **mod.ini** | Per-mod shader overrides. `ShaderOverride` sections with hashes |
| **Frame Analysis** | Shift+F11 dump all draw calls → diff tool → new hashes |

## Planned

- [ ] **Weird Tool GUI** — all-in-one desktop app: mod manager, frame diff viewer, shader hunter helper, one-click deploy
- [ ] **Model Swap** — import custom 3D models, replace in-game character/enemy models via buffer override
- [ ] **Auto Deploy** — watch repo file changes, auto-sync to EFMI Mods folder, hot-reload on save

## Safety

All mods use EFMI runtime injection. Arknights: Endfield uses **ACE kernel-level anti-cheat**. See [official policy](https://endfield.gryphline.com/zh-tw/news/8900).

- Only use on alt accounts
- Never post modded screenshots tied to your account
- Accept permanent ban as possible outcome

## License & Disclaimer

This mod is **open source and free** for learning and exchange purposes only.

By using this mod or any derivative work, you agree to be bound by all terms of this agreement. If you do not agree, you must immediately stop using it.

**You may NOT:**
- Discuss, mention, or share any content related to this mod on **森空岛 (Skland)**
- Discuss, mention, or share any content related to this mod in any official Arknights / Hypergryph channels across all platforms (including but not limited to Bilibili, Weibo), including comment sections, danmaku, posts, and any interactive areas under official announcements, news, or videos

## Setup

1. Install [XXMI Launcher](https://github.com/SpectrumQT/XXMI-Launcher) + EFMI
2. Clone into `<XXMI>\EFMI\Mods\` or symlink individual tool folders
3. Launch Endfield through XXMI, press F10 in-game to load

## Credits

- EFMI Tools: https://github.com/SpectrumQT/EFMI-Tools
- XXMI Launcher: https://github.com/SpectrumQT/XXMI-Launcher
- 3dmigoto: https://github.com/bo3b/3Dmigoto
