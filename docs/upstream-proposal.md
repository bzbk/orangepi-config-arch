# 向 Orange Pi 官方申请合并（proposal）

目标仓库：<https://github.com/orangepi-xunlong/orangepi-build>

## 建议方式（按可行性排序）

1. **Issue（推荐先做）**：在 orangepi-build 提 issue，标题
   `[Feature] orangepi-config for Arch Linux ARM (community port)`，正文附：
   - 官方脚本原样来源（`/usr/sbin/orangepi-config` + `/usr/lib/orangepi-config/*.sh`，来自
     `Orangepizero4_1.0.0_ubuntu_resolute_server_linux6.6.98`）
   - apt→pacman 的完整 patch（本仓库 `patches/apt-to-pacman.patch`）
   - 实机验证记录（Zero4，Firmware 菜单实际执行 `pacman -Sy && pacman -Su` 成功）
   - 建议放置目录：`external/packages/bsp/orangepi-config-arch/`（或 `external/cache/sources/` 下）
   - 说明 Arch 用户可自行 `install.sh` 安装，不需要纳入 Debian 构建流程
2. **PR**：把本仓库 `src/` 下的 `usr/bin/orangepi-config`、`usr/lib/orangepi-config/*.sh`、
   `usr/local/bin` shims、`README` 作为新增目录提交；不修改现有 Debian 构建逻辑，风险低。
   若维护者接受 "Arch 支持插件/脚本" 模式，可进一步在 `build.sh` 增加 `ARCH=arm64` 分支（工作量大，
   需与维护者确认）。
3. 备选：orangepi-build 的配置脚本源自 Armbian，也可向 Armbian 社区提交 Arch 适配补丁供参考。

## 注意事项

- 上游默认分支为 `next`；PR 请基于该分支。
- 上游项目主要面向 Debian/Ubuntu 构建，Arch 不在其支持矩阵内，合并成“官方构建目标”的可能性较低；
  更现实的是接受“独立社区移植 + 链接/脚本”形式。
