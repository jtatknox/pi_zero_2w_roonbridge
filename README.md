# Roon Bridge Setup for Raspberry Pi Zero 2W

This repository provides a simple Bash script to install and optimize Roon Bridge on a Raspberry Pi Zero 2W.
The script applies several system tweaks to improve network stability and reduce audio streaming latency.

## Features

### Audio device configuration
Sets ALSA to use the primary hardware card by default (/etc/asound.conf).

### Service cleanup
Disables non-essential services to free resources:
bluetooth, hciuart, triggerhappy, apt-daily, and apt-daily-upgrade.

### CPU governor tuning
Installs cpufrequtils and forces the CPU governor to performance mode for stable timing.

### Wi-Fi power management
Disables Wi-Fi power saving at boot to reduce dropouts.

### Kernel networking parameters
Applies sysctl tuning for low-latency streaming, increasing TCP buffer sizes and enabling low-latency mode.

### Roon Bridge installation
Downloads and installs the latest ARMv8 build of Roon Bridge from Roon Labs.

## Usage

Clone or download this repository, then run the script as root.

## Notes

Script is intended for Raspberry Pi Zero 2W but should also work on other ARMv8-based Raspberry Pi boards.

After reboot, the system should automatically run Roon Bridge and be discoverable by your Roon Core.

The script is idempotent: re-running it will simply reapply settings.
