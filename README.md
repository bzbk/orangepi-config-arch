# orangepi-config-arch

> **Official Orange Pi configuration tool (`orangepi-config`) ported to Arch Linux ARM.**
> 官方 Orange Pi 配置工具 `orangepi-config` 的 Arch Linux ARM 移植版：把 Debian/Ubuntu 的
> `apt / dpkg / service` 调用替换为 `pacman / systemctl`，保留官方菜单结构与操作逻辑。

[![License: GPL-2.0](https://img.shields.io/badge/License-GPL--2.0-blue.svg)](LICENSE)

## 来源 / Origin

脚本直接取自 **Orange Pi 官方 Ubuntu 镜像**
`Orangepizero4_1.0.0_ubuntu_resolute_server_linux6.6.98`：

- `/usr/sbin/orangepi-config`（177 行菜单前端）
- `/usr/lib/orangepi-config/{functions,functions-network,jobs,submenu}.sh`（约 128 KB 功能库）

上游构建项目：[`orangepi-xunlong/orangepi-build`](https://github.com/orangepi-xunlong/orangepi-build)（GPL-2.0）。
原始文件保存在本仓库 [`upstream/`](upstream/) 目录，便于对比与向上游提交。

## 做了哪些改动 / Changes

| Debian/Ubuntu | Arch Linux ARM |
|---|---|
| `apt-get update` / `apt-get -y upgrade` | `pacman -Sy --noconfirm` / `pacman -Su --noconfirm` |
| `apt-get -y install X` | `pacman -S --noconfirm --needed X` |
| `apt-get -y purge X` | `pacman -Rns --noconfirm X` |
| `dpkg -s X`（`check_if_installed`） | `pacman -Q X` |
| `is_package_manager_running`（apt/dpkg） | 检查 `pacman` 进程 |
| `service avahi-daemon …` | `systemctl … avahi-daemon` |
| `dpkg-reconfigure openssh-server` | `ssh-keygen -A; systemctl restart sshd` |
| 菜单文字 `Run apt update & apt upgrade` | `Run pacman update & upgrade` |
| `OVERLAYDIR` 未识别 `sun60iw2` | 增加 `sun60iw2` → `/boot/dtb/allwinner/overlay` 映射 |

此外保留一层**极薄的兼容 shim**（`src/usr/local/bin/`）：`apt`、`apt-get`、`dpkg`、`dpkg-query`、
`lsb_release`、`debconf-apt-progress`、`service`、`dpkg-reconfigure`，用于兜底官方脚本中少量未替换的
Debian 调用。完整 diff 见 [`patches/apt-to-pacman.patch`](patches/apt-to-pacman.patch)。

## 安装 / Install

```bash
git clone https://github.com/bzbk/orangepi-config-arch.git
cd orangepi-config-arch
sudo ./install.sh
sudo orangepi-config
```

依赖（`install.sh` 会自动用 pacman 安装）：`dialog wget git lsb-release bc`；
可选：`qrencode`、`libpam-google-authenticator`（SSH 两步验证菜单用）。

## 使用 / Usage

```bash
sudo orangepi-config                      # 主菜单
sudo orangepi-config --help               # 官方参数式用法
sudo orangepi-config main=System selection=Firmware   # 脚本式调用
```

菜单项（与官方一致）：**System**（Bootenv / Hardware / Avahi / SSH / Firmware / BASH / ZSH…）、
**Network**、**Personal**、**Software**、**Help**。

## 已验证 / Tested

- 硬件：Orange Pi Zero 4（Allwinner A733 / sun60iw2），Arch Linux ARM aarch64
- `Firmware` 菜单实际执行 `pacman -Sy && pacman -Su` 成功（系统已升级）
- `Hardware` 菜单正确列出 `/boot/dtb/allwinner/overlay/sun60i-a733-*.dtbo`
- `check_if_installed` 按 pacman 判断；`--help` 输出与官方一致
- MOTD（`/etc/update-motd.d`）配合系统 PAM 工作正常

## 已知限制 / Limitations

- 官方脚本中少量 Debian 专属功能在 Arch 上不可用（如安装 `.deb`、`linux-image-*`/`linux-u-boot-*`
  内核包切换、`apt` 源镜像切换、overlayroot 等）——这些依赖 Orange Pi 的 Debian 包仓库。
- 需要 Arch 的 `lsb_release`（包 `lsb-release`）；`service` 通过 shim 映射到 `systemctl`。

## 相关项目

- [bzbk/orangepi-zero4-arch](https://github.com/bzbk/orangepi-zero4-arch) — 本项目产出的
  Orange Pi Zero 4 Arch Linux ARM 可启动镜像（tty / XFCE / KDE）

## License

GPL-2.0（与上游 orangepi-build / Armbian 配置脚本一致）。见 [LICENSE](LICENSE)。
