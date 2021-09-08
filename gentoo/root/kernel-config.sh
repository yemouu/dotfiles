#!/bin/sh
# Configure kernel

# Exit on error
set -e

# command to change config options
cmd=./scripts/config

# Disable module loading
$cmd -d modules

# Enable IKCONFIG for inspecting kernel config during runtime
$cmd -e ikconfig
$cmd -e ikconfig_proc

# Enable EXPERT mode
$cmd -e expert

# Append a string to the kernel version
$cmd --set-str localversion "-mou-laptop"

# Enable ThinLTO
$cmd -d lto_none
$cmd -e lto_clang_thin

# Disable AMD CPU specific options
$cmd -d x86_mce_amd
$cmd -d microcode_amd
$cmd -d agp_amd64
$cmd -d amd_immou

# Disable CDROM support
$cmd -d blk_dev_sr
$cmd -d iso9660_fs

# Disable uneeded USB Host Controllers
$cmd -d usb_ehci_hcd
$cmd -d usb_ohci_hcd
$cmd -d usb_uhci_hcd

# Enable support for filesystems
$cmd -e btrfs_fs
$cmd -e btrfs_fs_posix_acl
$cmd -e fuse_fs

# Enable battery reporting for HID
$cmd -e hid_battery_strength

# Enable GPT
$cmd -e partition_advanced

# Enable webcam support
$cmd -e media_support
$cmd -e media_camera_support
$cmd -e media_usb_support
$cmd -e usb_video_class

# Enable set kernel command line options
$cmd -e cmdline_bool
$cmd --set-str cmdline "root=PARTUUID=8cfe7af7-77eb-b246-8095-dedbf3e409f3 rootflags=subvolid=256 resume=UUID=aa573578-0f21-47b0-bf3a-8e8328dd20de resume_offset=10849834"

# Load extra firmware
$cmd --set-str extra_firmware "regulatory.db regulatory.db.p7s intel-ucode/06-8c-01"

# Wifi Support
$cmd -e cfg80211_wext
$cmd -e iwlwifi
$cmd -e iwlmvm
$cmd -d wlan_vendor_admtek
$cmd -d wlan_vendor_ath
$cmd -d wlan_vendor_atmel
$cmd -d wlan_vendor_broadcom
$cmd -d wlan_vendor_cisco
$cmd -d wlan_vendor_intersil
$cmd -d wlan_vendor_marvell
$cmd -d wlan_vendor_mediatek
$cmd -d wlan_vendor_microchip
$cmd -d wlan_vendor_ralink
$cmd -d wlan_vendor_realtek
$cmd -d wlan_vendor_rsi
$cmd -d wlan_vendor_st
$cmd -d wlan_vendor_ti
$cmd -d wlan_vendor_zydas
$cmd -d wlan_vendor_quantenna
$cmd -e crypto_aes_ni_intel

# Power management
$cmd -e cpu_freq_stat
$cmd -d cpu_freq_default_gov_userspace
$cmd -e cpu_freq_default_gov_performance
$cmd -e cpu_freq_gov_powersave
$cmd -e cpu_freq_gov_conservative
$cmd -e pm_advanced_debug
$cmd -e acpi_processor_aggregator
$cmd -e acpi_sbs
$cmd -e acpi_hed
$cmd -e acpi_apei
$cmd -e acpi_apei_ghes

# Thermals
$cmd -e thermal_gov_fair_share
$cmd -e thermal_gov_bang_bang
$cmd -e intel_powerclamp
$cmd -e int340x_thermal
$cmd -e int3406_thermal
$cmd -e intel_pch_thermal
$cmd -e intel_tcc_cooling
$cmd -e powercap
$cmd -e intel_rapl

# Graphics
$cmd -e fb
$cmd -e fb_efi
$cmd -e drm_i915_gvt
$cmd -e framebuffer_console

# IOMMU
$cmd -e intel_iommu_default_on

# Boot Logo
$cmd -e logo
