# EndField Weird Tool

[English](README.md) | 中文版

基于 EFMI/3dmigoto 的明日方舟：终末地 shader-hunting 模组。奇怪工具，奇怪需求。

## 现有工具

### [InvisibleOp](InvisibleOp/)

通过跳过 GPU 绘制调用隐藏干员、Boss、图标和特效。131 个 hunted shader hash，覆盖 6 个类别。

- F1 总开关、F2 干员、F3 Boss
- 帧分析 diff 工具捕获短暂技能特效
- 支持 PS 和 VS 双模式 shader hunting

## Shader Hunting 技术栈

以下工具共用同一套底层，理解一个就能触类旁通。

| 组件 | 说明 |
|------|------|
| **EFMI** | 终末地专用 3dmigoto 分支。DLL 注入，shader 覆盖引擎 |
| **XXMI Launcher** | Mod 管理器。处理 EFMI 注入、mod 加载、分游戏配置 |
| **d3dx.ini** | EFMI 全局配置。Hunting 键位、帧分析设置 |
| **mod.ini** | 每个 mod 的 shader 覆盖规则。`ShaderOverride` 段 + hash |
| **帧分析** | Shift+F11 导出全部绘制调用 → diff 工具 → 新 hash |

## 计划

- [ ] **Weird Tool GUI** — 一体化桌面应用：mod 管理器、帧分析查看器、shader 狩猎辅助、一键部署
- [ ] **模型替换** — 导入自定义 3D 模型，通过 buffer override 替换游戏内角色/敌人模型
- [ ] **自动部署** — 监听文件变更，自动同步到 EFMI Mods 目录，保存即热加载

## 安全警告

所有模组均使用 EFMI 运行时注入。明日方舟：终末地使用 **ACE 内核级反作弊**。参考[官方政策](https://endfield.gryphline.com/zh-tw/news/8900)。

- 仅限小号使用
- 多人/联机模式下禁用所有 mod
- 切勿发布与账号关联的 mod 截图
- 接受永久封禁作为可能结果

## 许可与免责

本 mod **开源免费**，仅供学习交流使用。

通过使用本 mod 及其衍生项目，即表示您同意接受本协议所有条款的约束。如您不同意本协议内容，则应立即停止使用。

**禁止以下行为：**
- 在**森空岛**平台讨论、提及或传播任何与本 mod 相关内容
- 在明日方舟及鹰角网络于各类平台（包括但不限于哔哩哔哩、微博等）所拥有的官方账号和发布的任何官方公告、信息、资讯、动态、帖子、视频等内容的交互区域（包括但不限于弹幕池、评论区等）中讨论、提及或传播任何与本 mod 相关的内容

## 安装

1. 安装 [XXMI Launcher](https://github.com/SpectrumQT/XXMI-Launcher) + EFMI
2. 克隆到 `<XXMI>\EFMI\Mods\` 或为单个工具文件夹创建符号链接
3. 通过 XXMI 启动终末地，游戏内按 F10 加载

## 致谢

- EFMI Tools：https://github.com/SpectrumQT/EFMI-Tools
- XXMI Launcher：https://github.com/SpectrumQT/XXMI-Launcher
- 3dmigoto：https://github.com/bo3b/3Dmigoto
