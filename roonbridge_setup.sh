#!/bin/bash
set -e

echo "Setting up audio device..."

echo "pcm.!default {
  type hw
  card 0
}
ctl.!default {
  type hw
  card 0
}" > /etc/asound.conf

echo "Disabling unnecessary services..."
systemctl disable bluetooth.service
systemctl disable hciuart.service
systemctl disable triggerhappy.service

echo "Setting CPU governor to performance..."
apt-get update
apt-get install -y cpufrequtils
echo "GOVERNOR=performance" > /etc/default/cpufrequtils
systemctl restart cpufrequtils

echo "Disabling Wi-Fi power management..."
(crontab -l 2>/dev/null; echo "@reboot /usr/sbin/iw wlan0 set power_save off") | crontab -

echo "Applying sysctl network tuning..."
cat << EOF >> /etc/sysctl.conf

# Tuning for low latency audio streaming
net.core.rmem_max=26214400
net.core.wmem_max=26214400
net.ipv4.tcp_rmem=10240 87380 26214400
net.ipv4.tcp_wmem=10240 87380 26214400
net.ipv4.tcp_low_latency=1
EOF

sysctl -p

echo "Installing RoonBridge..."
curl -O https://download.roonlabs.net/builds/roonbridge-installer-linuxarmv8.sh
chmod +x roonbridge-installer-linuxarmv8.sh
sudo ./roonbridge-installer-linuxarmv8.sh
rm roonbridge-installer-linuxarmv8.sh

echo "Setup complete. Please reboot."
