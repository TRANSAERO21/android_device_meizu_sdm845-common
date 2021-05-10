#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

VENDOR=meizu
DEVICE_COMMON=sdm845

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
. "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true
SECTION=
KANG=
DEVICE=

while [ "$1" != "" ]; do
    case "$1" in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -k | --kang)            KANG="--kang"
                                ;;
        -s | --section )        shift
                                SECTION="$1"
                                CLEAN_VENDOR=false
                                ;;
        --m1882 )               DEVICE=m1882
                                ;;
        --m1892 )               DEVICE=m1892
                                ;;
        * )                     SRC="$1"
                                ;;
    esac
    shift
done

if [ -z "${DEVICE}" ]; then
    echo "The device name was not selected!"
    echo "Use --m1882 (if 16th) or --m1892 (if 16thPlus)!"
    exit 1
fi

if [ -z "${SRC}" ]; then
    SRC=adb
fi

function blob_fixup() {
    case "${1}" in
    vendor/bin/hw/vendor.display.color@1.0-service | vendor/bin/hw/vendor.qti.hardware.qteeconnector@1.0-service | vendor/lib/vendor.display.postproc@1.0_vendor.so)
        patchelf --remove-needed "android.hidl.base@1.0.so" "${2}"
        ;;
    vendor/lib64/hw/vendor.qti.hardware.sensorscalibrate@1.0-impl.so)
        sed -i "s|libbase.so|libbv28.so|g" "${2}"
        ;;
    vendor/lib/hw/camera.qcom.so)
        sed -i "s|libssc.so|libSSc.so|g" "${2}"
        ;;
    vendor/lib/libmms_hal_vstab.so | vendor/lib/libmms_warper_vstab.so)
        if [ -z $(patchelf --print-needed "${2}" | grep "libshim_camera.so") ]; then
            patchelf --add-needed "libshim_camera.so" "${2}"
        fi
        ;;
    vendor/lib/camera/components/com.inv.node.eis.so)
        if [ -z $(patchelf --print-needed "${2}" | grep "libprotobuf-cpp-full-vendor-3.9.1.so") ]; then
            patchelf --add-needed "libprotobuf-cpp-full-vendor-3.9.1.so" "${2}"
        fi
        ;;
    etc/vstab_db_0_720p_video_30fps.config | etc/vstab_db_0_4k_video_30fps.config | etc/vstab_db_0_1080p_video_30fps.config | vendor/lib/camera/components/com.arcsoft.node.realtimebokeh.so | vendor/lib/camera/components/com.qti.stats.pdlib.so | vendor/lib/camera/components/com.arcsoft.node.capturebokeh.so | vendor/lib/camera/components/com.arcsoft.node.picauto.so | vendor/lib/camera/components/com.inv.node.eis.so | vendor/lib/camera/components/com.arcsoft.node.hdr.so | vendor/lib/camera/components/com.qti.stats.aec.so | vendor/lib/camera/components/com.arcsoft.node.beauty.so | vendor/lib/camera/components/com.arcsoft.node.smoothtransition.so | vendor/lib/camera/components/com.arcsoft.node.lowlighthdr.so | vendor/lib/libmms_hal_vstab.so | vendor/lib/libarcsoft_dualcam_refocus.so | vendor/lib/hw/com.qti.chi.override.so | vendor/lib/hw/camera.qcom.so)
        sed -i "s|/data/misc/camera|/data/vendor/cumX|g" "${2}"
        ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files-common.txt" "${SRC}" ${KANG} --section "${SECTION}"

if [ -n "${DEVICE}" ]; then
    # Reinitialize the helper for device
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

    extract "${MY_DIR}/${DEVICE}/proprietary-files-${DEVICE}.txt" "${SRC}"
fi

"${MY_DIR}/setup-makefiles.sh" "--${DEVICE}"
