# Changes vs. official Orange Pi scripts

Source: official Ubuntu image `Orangepizero4_1.0.0_ubuntu_resolute_server_linux6.6.98`
(`/usr/sbin/orangepi-config`, `/usr/lib/orangepi-config/*.sh`).

Original files are kept in `upstream/`; applied diff: `patches/apt-to-pacman.patch`.

## 2026-10-20 — v1.0.0

### Package management
- `apt-get update` → `pacman -Sy --noconfirm`
- `apt-get upgrade` / `apt -y upgrade` → `pacman -Su --noconfirm`
- `apt-get install …` → `pacman -S --noconfirm --needed …`
- `apt-get purge/remove …` → `pacman -Rns --noconfirm …`
- `dpkg -s` → `pacman -Q`
- `is_package_manager_running()` checks `pacman`
- Debian package names mapped where needed (`avahi-daemon`→`avahi`, `openssh-server`→`openssh`,
  `wireless-tools`→`wireless_tools`)

### System services
- `service X …` → `systemctl … X`
- `dpkg-reconfigure openssh-server` → `ssh-keygen -A; systemctl restart sshd`

### Board specifics
- `OVERLAYDIR` mapping for `sun60iw2` (`/boot/dtb/allwinner/overlay`); `/boot/dtb/overlay` symlink
  is created by the image build (install.sh also creates it when missing)
- MOTD script `40-orangepi-updates` uses `pacman -Qu` instead of apt cache

### UI text
- `Run apt update & apt upgrade` → `Run pacman update & upgrade`
