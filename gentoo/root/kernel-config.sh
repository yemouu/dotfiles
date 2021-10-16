#!/bin/sh
# Configure kernel

# Some things enabled here can most likely be disabled and I may be missing some stuff
# Hopefully this will become more refined overtime

# Exit on error
set -e

# ./scripts/config will exit silently. Make it fail loudly instead
cmd() {
	./scripts/config "$@" || {
		printf '%s\n' "${0##*/}: ./scripts/config $*: had an error" 1>&2
		exit 1
	}
}

# Append a string to the kernel version
cmd --set-str localversion "-mou-laptop"

# Enable EXPERT mode
cmd -e expert

# Disable module loading
cmd -d modules

# Disable Initramfs
cmd -d blk_dev_initrd

# Enable IKCONFIG for inspecting kernel config during runtime
cmd -e ikconfig
cmd -e ikconfig_proc

# Enable Kernel Compression with ZSTD
cmd -d kernel_gzip
cmd -e kernel_zstd

# Enable ThinLTO
cmd -d lto_none
cmd -e lto_clang_thin

# Disable AMD CPU specific options
cmd -d x86_mce_amd
cmd -d microcode_amd
cmd -d agp_amd64
cmd -d amd_immou
cmd -d amd_numa

# CPU Options
cmd -e sched_core
cmd -e processor_select
cmd -d cpu_sup_hygon
cmd -d cpu_sup_amd
cmd -d cpu_sup_centaur
cmd -d cpu_sup_zhaoxin
cmd --set-val nr_cpus 8

# Disable CDROM support
cmd -d blk_dev_sr
cmd -d iso9660_fs

# USB
cmd -d usb_ehci_hcd
cmd -d usb_ohci_hcd
cmd -d usb_uhci_hcd
cmd -e usb_led_trig
cmd -e typec
cmd -e typec_dp_altmode
cmd -e usb4

# Enable support for filesystems
cmd -e btrfs_fs
cmd -e btrfs_fs_posix_acl
cmd -e fuse_fs
cmd -e exfat_fs
cmd -e ntfs_fs
cmd -e ntfs_rw
cmd -e unicode


# Enable GPT
cmd -e partition_advanced

# Enable webcam support
cmd -e media_support
cmd -e media_camera_support
cmd -e media_usb_support
cmd -e usb_video_class

# Enable set kernel command line options
cmd -e cmdline_bool
cmd --set-str cmdline "root=PARTUUID=8cfe7af7-77eb-b246-8095-dedbf3e409f3 rootflags=subvolid=256 resume=UUID=aa573578-0f21-47b0-bf3a-8e8328dd20de resume_offset=10849834"

# Load extra firmware
cmd --set-str extra_firmware "intel-ucode/06-8c-01 regulatory.db regulatory.db.p7s iwlwifi-QuZ-a0-hr-b0-63.ucode intel/ibt-19-0-4.sfi i915/tgl_dmc_ver2_08.bin intel/sof/sof-tgl.ri intel/sof-tplg/sof-hda-generic-4ch.tplg"

# Networking
cmd -e cfg80211_wext
cmd -e iwlwifi
cmd -e iwlmvm
cmd -e iwldvm
cmd -d wlan_vendor_admtek
cmd -d wlan_vendor_ath
cmd -d wlan_vendor_atmel
cmd -d wlan_vendor_broadcom
cmd -d wlan_vendor_cisco
cmd -d wlan_vendor_intersil
cmd -d wlan_vendor_marvell
cmd -d wlan_vendor_mediatek
cmd -d wlan_vendor_microchip
cmd -d wlan_vendor_ralink
cmd -d wlan_vendor_realtek
cmd -d wlan_vendor_rsi
cmd -d wlan_vendor_st
cmd -d wlan_vendor_ti
cmd -d wlan_vendor_zydas
cmd -d wlan_vendor_quantenna
cmd -e crypto_aes_ni_intel
cmd -e bridge
cmd -e vlan_8021q
cmd -e macvlan
cmd -e veth
cmd -e bt
cmd -e bt_rfcomm
cmd -e bt_hidp
cmd -e bt_hs
cmd -e bt_hcibtusb
cmd -e bt_hciuart


# Power management
cmd -e cpu_freq_stat
cmd -d cpu_freq_default_gov_userspace
cmd -e cpu_freq_default_gov_performance
cmd -e cpu_freq_gov_powersave
cmd -e cpu_freq_gov_conservative
cmd -e pm_advanced_debug
cmd -e acpi_processor_aggregator
cmd -e acpi_sbs
cmd -e acpi_hed
cmd -e acpi_apei
cmd -e acpi_apei_ghes
cmd -e pm_autosleep
cmd -e pm_wakelocks
cmd -e energy_model
cmd -e acpi_dptf
cmd -e pmic_opregion
cmd -e intel_idle
cmd -e mfd_intel_lpss_acpi
cmd -e mfd_intel_lpss_pci
cmd -e thinkpad_acpi
cmd -e x86_intel_lpss
cmd -e pinctrl_tigerlake
cmd -e intel_idma64

# Thermals
cmd -e thermal_gov_fair_share
cmd -e thermal_gov_bang_bang
cmd -e intel_powerclamp
cmd -e int340x_thermal
cmd -e int3406_thermal
cmd -e intel_pch_thermal
cmd -e intel_tcc_cooling
cmd -e powercap
cmd -e intel_rapl
cmd -e thermal_gov_power_allocator

# Graphics
cmd -e fb
cmd -e fb_efi
cmd -e drm_i915_gvt
cmd -e framebuffer_console

# IOMMU
cmd -e intel_iommu_default_on

# Boot Logo
cmd -e logo

# I2C
cmd -e i2c_chardef
cmd -e i2c_scmi
cmd -e i2c_designware_platform
cmd -e i2c_designware_pci

# HID
cmd -e hid_lenovo
cmd -e hid_playstation
cmd -e hid_playstation_ff
cmd -e hid_roccat
cmd -e sony_ff
cmd -e hid_rmi
cmd -e hid_wacom
cmd -e uhid
cmd -e intel_ish_hid
cmd -e intel_ish_firmware_downloader
cmd -e hid_multitouch
cmd -e hid_battery_strength

# PCI
cmd -e hotplug_pci_pcie
cmd -e hotplug_pci_acpi
cmd -e pcie_ptm

# Input
cmd -e mouse_synaptics_i2c
cmd -e input_joydev
cmd -e tablet_serial_wacom4
cmd -e touchscreen_wacom_w8001
cmd -e touchscreen_wacom_i2c
cmd -e i2c_hid_acpi
cmd -e input_uinput
cmd -d macintosh_drivers
cmd -e rmi4_i2c
cmd -e rmi4_smb
cmd -e rmi4_f34
cmd -e rmi4_f3a
cmd -e rmi4_f54

# Audio
cmd -e snd_usb_audio
cmd -e snd_hda_codec_realtek
cmd -e snd_hda_codec_hdmi
cmd -e snd_hda_intel_hdmi_silent_stream
cmd -e snd_soc
cmd -e snd_soc_sof_toplevel
cmd -e snd_soc_sof_pci
cmd -e snd_soc_sof_acpi
cmd -e snd_soc_sof_intel_toplevel
cmd -e snd_soc_sof_hda_link
cmd -e snd_soc_sof_hda_audio_codec
cmd -e snd_soc_intel_skl
cmd -e snd_soc_intel_apl
cmd -e snd_soc_intel_kbl
cmd -e snd_soc_intel_glk
cmd -e snd_soc_intel_cnl
cmd -e snd_soc_intel_cfl
cmd -e snd_soc_intel_cml_h
cmd -e snd_soc_intel_cml_lp
cmd -e snd_soc_intel_skylake_hdaudio_codec
cmd -e snd_soc_intel_skl_hda_dsp_generic_mach

# Device Monitoring
cmd -e i2c_chardev
cmd -e sensors_i5500
cmd -e sensors_coretemp
cmd -e sensors_acpi_power

# NVMe & IO
cmd -e blk_dev_nvme
cmd -e nvme_multipath
cmd -e nvme_hwmon
cmd -e iosched_bfq
cmd -e bfq_group_iosched
cmd -d md

# Control groups and Namespaces
cmd -e cgroup_device
cmd -e memcg
cmd -e cgroup_perf
cmd -e blk_cgroup
cmd -e user_ns
cmd -e sched_autogroup
cmd -e cgroup_pids

# Virtualization
cmd -e kvm
cmd -e kvm_intel
cmd -e vhost_net
cmd -e tun

# Memory Options
cmd -e ksm
cmd -e cleancache
cmd -e frontswap
cmd -e zswap
cmd -d zswap_compressor_default_lzo
cmd -e zswap_compressor_default_zstd
cmd -d zswap_zpool_default_zbud
cmd -e zswap_zpool_default_z3fold
cmd -e zswap_default_on

# Security
cmd -e slab_freelist_random
cmd -e slab_freelist_hardened
cmd -e shuffle_page_allocator
cmd -e randomize_kstack_offset_default
cmd -d security_selinux

# Font (internal monitor is 4K so a bigger font would be nice)
cmd -e fonts
cmd -d font_autoselect
cmd -k -e FONT_TER16x32

# Multimedia
cmd -e media_support_filter

# MISC
cmd -d pccard
cmd -d surface_platforms
cmd -e acpi_wmi

# Steam
cmd -e psi

# iwd
cmd -e key_dh_operations
cmd -e crypto_md4
cmd -e crypto_sha1
cmd -e crypto_sha1_ssse3
cmd -e crypto_sha256_ssse3
cmd -e crypto_sha512_ssse3
cmd -e crypto_des
cmd -e crypto_des3_ede_x86_64
cmd -e crypto_user_api_hash
cmd -e crypto_user_api_skcipher
cmd -e pkcs8_private_key_parser

# bluez
cmd -e bt_rfcomm_tty
cmd -e bt_bnep
cmd -e bt_bnep_mc_filter
cmd -e bt_bnep_proto_filter
cmd -e crypto_user
cmd -e crypto_user_api_aead
