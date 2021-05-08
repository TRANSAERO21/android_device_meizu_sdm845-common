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
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ANDROID_ROOT="$MY_DIR"/../../..

HELPER="$ANDROID_ROOT"/vendor/lineage/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

while [ "$1" != "" ]; do
    case "$1" in
        --m1882 )               DEVICE=m1882
                                ;;
        --m1892 )               DEVICE=m1892
                                ;;
    esac
    shift
done

if [ -z "${DEVICE}" ]; then
    echo "The device name was not selected!"
    echo "Use --m1882 (if 16th) or --m1892 (if 16thPlus)!"
    exit 1
fi

# Initialize the helper
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$ANDROID_ROOT" true

# Copyright headers and guards
write_headers "m1882 m1892"

write_makefiles "${MY_DIR}/proprietary-files-common.txt" true

# Finish
write_footers

if [ -n "${DEVICE}" ]; then
    # Reinitialize the helper for device
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false

      # Copyright headers and guards
    write_headers

    # The standard device blobs
    write_makefiles "${MY_DIR}/${DEVICE}/proprietary-files-${DEVICE}.txt" true

    # Finish
    write_footers
fi
