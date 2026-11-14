#!/bin/bash
# DIY Part 2: Execute before make menuconfig

echo "DIY Part 2: Custom settings"

# Modify default IP
echo "Setting default IP to 192.168.1.1..."
sed -i 's/192.168.1.1/192.168.1.1/g' \
  package/base-files/files/bin/config_generate

# Modify default hostname
echo "Setting hostname to JDCloud..."
sed -i 's/ImmortalWrt/JDCloud/g' \
  package/base-files/files/bin/config_generate

# Modify default timezone
echo "Setting timezone to Asia/Shanghai..."

CONFIG_GENERATE="package/base-files/files/bin/config_generate"

# 不要使用 CST-8。
# CST-8 是 POSIX 时区写法，但会被部分 LuCI JavaScript 页面当成浏览器时区，
# 从而触发：RangeError: Invalid time zone specified: CST-8
sed -i "s/'UTC'/'Asia\\/Shanghai'/g" "$CONFIG_GENERATE"

# Modify default theme
echo "Setting default theme to Argon..."
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' \
  feeds/luci/collections/luci/Makefile 2>/dev/null || true

# Clear root password
echo "Clearing root password..."
sed -i 's/root:.*/root:::0:99999:7:::/g' \
  package/base-files/files/etc/shadow

echo "DIY Part 2: Done"
