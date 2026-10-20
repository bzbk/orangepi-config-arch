#!/bin/bash
# Uninstall orangepi-config-arch
set -e
[ "$(id -u)" -eq 0 ] || { echo "Please run as root: sudo ./uninstall.sh"; exit 1; }
rm -f /usr/bin/orangepi-config
rm -rf /usr/lib/orangepi-config
for b in apt apt-get dpkg dpkg-query lsb_release debconf-apt-progress service dpkg-reconfigure; do
  rm -f "/usr/local/bin/$b"
done
echo "==> Removed orangepi-config-arch"
