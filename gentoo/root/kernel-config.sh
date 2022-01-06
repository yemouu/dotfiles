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

# ------------- #
# General Setup #
# ------------- #

# Append a string to the kernel version for identification
cmd --set-str localversion "-$(hostname)"

cmd -d kernel_gzip
cmd -e kernel_zstd
cmd -e werror
cmd -e watch_queue
cmd -d uselib
cmd -d no_hz_idle
cmd -e no_hz_full
cmd -e bpf_syscall
cmd -e bpf_jit
cmd -e bpf_jit_always_on
cmd -e bpf_unpriv_default_off
cmd -d preempt_voluntary
cmd -e preempt
cmd -e sched_core
cmd -e bsd_process_acct_v3

# Steam
cmd -e psi

cmd -e ikconfig
cmd -e ikconfig_proc
cmd -m ikheaders
cmd -e printk_index

# CGroups
cmd -e memcg
cmd -e blk_cgroup
cmd -e cfs_bandwidth
cmd -e cgroup_pids
cmd -d cgroup_freezer
cmd -e cgroup_hugetlb
cmd -e cgroup_device
cmd -e cgroup_perf
cmd -e cgroup_bpf
cmd -e cgroup_misc

cmd -e sched_autogroup
cmd -d blk_dev_initrd
cmd -e expert
cmd -e userfaultfd
cmd -e slab_freelist_random
cmd -e slab_freelist_hardened
cmd -e shuffle_page_allocator

# --------------------------- #
# Processor type and features #
# --------------------------- #

cmd -d x86_mpparse
cmd -e x86_cpu_resctrl
cmd -d x86_extended_platform
cmd -e x86_intel_lpss
cmd -d generic_cpu
cmd -e mcore2
cmd -e processor_select
cmd -d cpu_sup_amd
cmd -d cpu_sup_hygon
cmd -d cpu_sup_centaur
cmd -d cpu_sup_zhaoxin
cmd --set-val nr_cpus 8
cmd -d microcode_amd
cmd -d amd_numa
cmd -m x86_pmem_legacy
cmd -e mtrr_sanitizer
cmd -d x86_intel_tsx_mode_off
cmd -e x86_intel_tsx_mode_auto
cmd -e x86_sgx
cmd -d efi_mixed
cmd -d kexec
cmd -d crash_dump
cmd -d legacy_vsyscall_xonly
cmd -e legacy_vsyscall_none
cmd -e cmdline_bool
cmd --set-str cmdline "root=PARTUUID=8cfe7af7-77eb-b246-8095-dedbf3e409f3"

# --------------------------------- #
# Power management and ACPI options #
# --------------------------------- #

cmd -e pm_autosleep
cmd -e pm_wakelocks
cmd -e energy_model
cmd -e acpi_fpdt
cmd -m acpi_ac
cmd -m acpi_battery
cmd -m acpi_button
cmd -m acpi_video
cmd -m acpi_tad
cmd -m acpi_processor_aggregator
cmd -m acpi_thermal
cmd -m acpi_sbs
cmd -m acpi_nfit
cmd -e acpi_apei
cmd -e acpi_apei_ghes
cmd -e acpi_dptf
cmd -e pmic_opregion
cmd -e cpu_freq_stat
cmd -d cpu_freq_default_gov_userspace
cmd -e cpu_freq_default_gov_powersave
cmd -d cpu_freq_gov_userspace
cmd -d cpu_freq_gov_ondemand
cmd -d cpu_freq_gov_conservative
cmd -d cpu_idle_gov_menu
cmd -e cpu_idle_gov_teo
cmd -e intel_idle

# -------------- #
# Virtualization #
# -------------- #

cmd -m kvm
cmd -m kvm_intel
cmd -e x86_sgx_kvm

# -------------------------------------- #
# General architecture-dependent options #
# -------------------------------------- #

cmd -d lto_none
cmd -e lto_clang_full
cmd -e randomize_kstack_offset_default

# ------------------------------ #
# Enable loadable module support #
# ------------------------------ #

cmd -d module_compress_none
cmd -e module_compress_zstd

# ------------- #
# IO Schedulers #
# ------------- #

cmd -m iosched_bfq
cmd -e bfq_group_iosched

# ------------------------- #
# Memory Management options #
# ------------------------- #

cmd -e memory_hotplug
cmd -e memory_hotremove
cmd -e ksm
cmd -e transparent_hugepage
cmd -e transparent_hugepage_madvise
cmd -e cleancache
cmd -e frontswap
cmd -e cma
cmd -e zswap
cmd -e zswap_compressor_default_zstd
cmd -e zswap_zpool_default_z3fold
cmd -e zswap_default_on
cmd -e deferred_struct_page_init
cmd -e zone_device
cmd -e device_private

# ------------------ #
# Networking support #
# ------------------ #

cmd -e packet_diag
cmd -e unix_diag
cmd -e net_key
cmd -d ip_advanced_router
cmd -d ip_pnp
cmd -e net_ipip
cmd -e inet_diag
cmd -e inet_udp_diag
cmd -e inet_raw_diag
cmd -e ipv6_tunnel
cmd -m nf_tables
cmd -m bridge

# -------------- #
# Device Drivers #
# -------------- #



# ------------ #
# File systems #
# ------------ #



# ---------------- #
# Security options #
# ---------------- #



# ----------------- #
# Cryptographic API #
# ----------------- #



# ---------------- #
# Library routines #
# ---------------- #



# -------------- #
# Kernel hacking #
# -------------- #


# Disable AMD CPU specific options
cmd -d agp_amd64
cmd -d amd_immou

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

# Enable webcam support
cmd -e media_support
cmd -e media_camera_support
cmd -e media_usb_support
cmd -e usb_video_class

# Load extra firmware
cmd --set-str extra_firmware "intel-ucode/06-8c-01"

# Networking
cmd -m cfg80211
cmd -m mac80211
cmd -e cfg80211_wext
cmd -m iwlwifi
cmd -m iwlmvm
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
cmd -e vlan_8021q
cmd -e macvlan
cmd -e veth
cmd -m bt
cmd -m bt_rfcomm
cmd -m bt_hidp
cmd -e bt_hs
cmd -e bt_hcibtusb
cmd -e bt_hciuart
cmd -m usb_usbnet
cmd -m usb_net_drivers
cmd -m usb_rtl8153_ecm

# Power management
cmd -e mfd_intel_lpss_acpi
cmd -e mfd_intel_lpss_pci
cmd -m thinkpad_acpi
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
cmd -m drm_i915
cmd -e drm_i915_gvt
cmd -e framebuffer_console
cmd -e vga_switcheroo
cmd -m drm_amdgpu
cmd -e drm_amdgpu_userptr
cmd -e drm_amd_dc_hdcp
cmd -e drm_amd_secure_display
cmd -e hsa_amd
cmd -e drm_amd_acp

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
cmd -m snd_soc
cmd -e snd_soc_sof_toplevel
cmd -m snd_soc_sof_pci
cmd -m snd_soc_sof_acpi
cmd -e snd_soc_sof_intel_toplevel
cmd -e snd_soc_sof_hda_link
cmd -e snd_soc_sof_hda_audio_codec
cmd -m snd_soc_intel_skl
cmd -m snd_soc_intel_apl
cmd -m snd_soc_intel_kbl
cmd -m snd_soc_intel_glk
cmd -m snd_soc_intel_cnl
cmd -m snd_soc_intel_cfl
cmd -m snd_soc_intel_cml_h
cmd -m snd_soc_intel_cml_lp
cmd -e snd_soc_intel_skylake_hdaudio_codec
cmd -m snd_soc_intel_skl_hda_dsp_generic_mach
cmd -e snd_hda_patch_loader

# Device Monitoring
cmd -e i2c_chardev
cmd -e sensors_i5500
cmd -e sensors_coretemp
cmd -e sensors_acpi_power

# NVMe & IO
cmd -e blk_dev_nvme
cmd -e nvme_multipath
cmd -e nvme_hwmon
cmd -d md

# Virtualization
cmd -e vhost_net
cmd -e tun

# Security
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

## Misc New (Organize this later)
cmd -e bt_leds
cmd -e hid_logitech_dj

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
cmd -m bt_bnep
cmd -e bt_bnep_mc_filter
cmd -e bt_bnep_proto_filter
cmd -e crypto_user
cmd -e crypto_user_api_aead
