#
# Copyright (C) 2020 The MoKee Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

BOARD_VENDOR := meizu

DEVICE_PATH := device/meizu/sdm845

TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

# Build
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Assertion
TARGET_OTA_ASSERT_DEVICE := m1882,16th

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm845
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xA84000 androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3 lpm_levels.sleep_disabled=1 service_locator.enable=1 loop.max_part=7
BOARD_KERNEL_CMDLINE += swiotlb=2048 androidboot.configfs=true androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/m1882/prebuilt/kernel
TARGET_FORCE_PREBUILT_KERNEL := true
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/m1882/prebuilt/dtbo.img
TARGET_KERNEL_HEADER_SOURCE := kernel/meizu/sdm845
TARGET_KERNEL_CONFIG := sdm845-perf_defconfig

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES := \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/mpq-adapter.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/mpq-dmx-hw-plugin.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/pinctrl-wcd.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/qca_cld3_wlan.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/rdbg.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-cs35l41-spi.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-cs35l41.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-sdm845.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-wcd-mbhc.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-wcd-spi.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-wcd934x.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/snd-soc-wcd9xxx.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/swr-wcd-ctrl.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/tspp.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/wcd-core.ko \
    $(DEVICE_PATH)/m1882/prebuilt/vendor-modules/wcd-dsp-glink.ko

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := sdm845
TARGET_BOARD_PLATFORM_GPU := qcom-adreno630

# Audio
AUDIO_FEATURE_ENABLED_AHAL_EXT := true
USE_DEVICE_SPECIFIC_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
USE_CAMERA_STUB := true
BOARD_QTI_CAMERA_32BIT_ONLY := true

# Charger
WITH_LINEAGE_CHARGER := false

# Display
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_OVERLAY := true
TARGET_USES_COLOR_METADATA := true
TARGET_CONTINUOUS_SPLASH_ENABLED := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 2
TARGET_SCREEN_DENSITY := 400

# DRM
TARGET_ENABLE_MEDIADRM_64 := true
TARGET_LD_SHIM_LIBS += /vendor/bin/hw/android.hardware.drm@1.3-service.clearkey|/vendor/lib64/libprotobuf-cpp-full-vendor-3.9.1.so

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# GPS
USE_DEVICE_SPECIFIC_GPS := true
USE_DEVICE_SPECIFIC_LOC_API := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Media
USE_DEVICE_SPECIFIC_MEDIA := true
TARGET_USES_MEDIA_EXTENSIONS := true

# Init
TARGET_INIT_VENDOR_LIB :=  //$(DEVICE_PATH):libinit_sdm845
TARGET_RECOVERY_DEVICE_MODULES := libinit_sdm845

# FOD
TARGET_SURFACEFLINGER_FOD_LIB := //$(DEVICE_PATH):libfod_extension.meizu_sdm845

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_COPY_OUT_VENDOR := vendor

# Power
TARGET_TAP_TO_WAKE_NODE := /dev/vendor.lineage.touch@1.0/dt2w
TARGET_USES_INTERACTION_BOOST := true

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_SYSTEM_PROP := $(DEVICE_PATH)/system.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/configs/recovery.fstab
TARGET_USERIMAGES_USE_EXT4 := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_msm

# Root
BOARD_ROOT_EXTRA_FOLDERS := \
    bt_firmware \
    dsp \
    firmware \
    persist

# RenderScript
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security patch level
VENDOR_SECURITY_PATCH := 2020-10-01

# SELinux
include device/qcom/sepolicy_vndr/SEPolicy.mk
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += $(DEVICE_PATH)/sepolicy/private

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Timeservice
BOARD_USES_QC_TIME_SERVICES := true

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
BOARD_VNDK_RUNTIME_DISABLE := true
BOARD_VNDK_VERSION := current

# Wi-Fi
BOARD_HAS_QCOM_WLAN := true
BOARD_HAS_QCOM_WLAN_SDK := true
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
QC_WIFI_HIDL_FEATURE_DUAL_AP := true
WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
WIFI_DRIVER_MODULE_NAME := "wlan"
WIFI_DRIVER_MODULE_PATH := "/vendor/lib/modules/qca_cld3_wlan.ko"
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# inherit from the proprietary version
-include vendor/meizu/m1882/BoardConfigVendor.mk
-include vendor/meizu/sdm845/BoardConfigVendor.mk
