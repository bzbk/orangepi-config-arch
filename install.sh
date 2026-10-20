#!/bin/bash
# Install orangepi-config-arch on Arch Linux ARM
set -e
[ "$(id -u)" -eq 0 ] || { echo "Please run as root: sudo ./install.sh"; exit 1; }
SRC="$(cd "$(dirname "$0")" && pwd)/src"
PKGS="dialog wget git lsb-release bc"
echo "==> Installing dependencies: $PKGS"
pacman -S --noconfirm --needed $PKGS || true
echo "==> Installing files"
install -Dm755 "$SRC/usr/bin/orangepi-config" /usr/bin/orangepi-config
mkdir -p /usr/lib/orangepi-config
install -m644 "$SRC"/usr/lib/orangepi-config/*.sh /usr/lib/orangepi-config/
mkdir -p /usr/local/bin
for f in "$SRC"/usr/local/bin/*; do
  b=$(basename "$f")
  if [ -e "/usr/local/bin/$b" ]; then
    echo "    (skip) /usr/local/bin/$b already exists"
  else
    install -m755 "$f" /usr/local/bin/"$b"
  fi
done
# shell completion / PATH: /usr/sbin -> /usr/bin on Arch
ln -sfn /boot/dtb/allwinner/overlay /boot/dtb/overlay 2>/dev/null || true
echo "==> Done. Run: sudo orangepi-config"
