# Issue text for orangepi-xunlong/orangepi-build

**Title:** `[Feature] orangepi-config for Arch Linux ARM (community port)`

**Body:**

## Proposal: orangepi-config for Arch Linux ARM (community port)

Hi Orange Pi team,

I maintain an Arch Linux ARM image for **Orange Pi Zero 4 (Allwinner A733 / sun60iw2)**
and have ported the official `orangepi-config` tool to Arch. Instead of rewriting it,
I took the **official files verbatim** from the official Ubuntu image
(`Orangepizero4_1.0.0_ubuntu_resolute_server_linux6.6.98`):

- `/usr/sbin/orangepi-config` (menu front-end)
- `/usr/lib/orangepi-config/{functions,functions-network,jobs,submenu}.sh`

and replaced only the Debian package-management calls (`apt`/`dpkg`/`service` → `pacman`/`systemctl`),
keeping menu structure, texts and operation logic identical. Sources + original files + patch:
**https://github.com/bzbk/orangepi-config-arch** (GPL-2.0)

**Tested** on Orange Pi Zero 4 with Arch Linux ARM:
- `System -> Firmware` actually runs `pacman -Sy && pacman -Su` (system upgraded successfully)
- `System -> Hardware` lists `/boot/dtb/allwinner/overlay/sun60i-a733-*.dtbo` and writes `overlays=` in `/boot/orangepiEnv.txt`
- `orangepi-config --help` output identical to official

**Suggested integration (low risk):** add as an optional/community component, e.g.
`external/packages/bsp/orangepi-config-arch/` (install script + files), without touching the
existing Debian build flow. Happy to send a PR if you can advise the preferred location.

Thanks!
