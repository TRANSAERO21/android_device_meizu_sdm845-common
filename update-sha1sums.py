#!/usr/bin/env python
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2021 The LineageOS Project
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

from hashlib import sha1
import sys

device_list = ['common', 'm1882', 'm1892']
vendor = 'meizu'

choice = input(
    f"Type proprietary list area (without brackets)\n'{device_list[0]}' for sdm845\n'{device_list[1]}' for 16th\n'{device_list[2]}' for 16thPlus\n")

if choice == device_list[0]:
    target_file = 'proprietary-files-common.txt'
    device = 'sdm845'
elif choice == device_list[1]:
    target_file = 'm1882/proprietary-files-m1882.txt'
    device = 'm1882'
elif choice == device_list[2]:
    target_file = 'm1892/proprietary-files-m1892.txt'
    device = 'm1892'
else:
    sys.exit('Nonexistent proprietary list area!\nExiting!')

lines = [line for line in open(target_file, 'r')]
vendorPath = '../../../vendor/' + vendor + '/' + device + '/proprietary'
needSHA1 = False


def cleanup():
    for index, line in enumerate(lines):
        # Remove '\n' character
        line = line[:-1]

        # Skip empty or commented lines
        if len(line) == 0 or line[0] == '#':
            continue

        # Drop SHA1 hash, if existing
        if '|' in line:
            line = line.split('|')[0]
            lines[index] = '%s\n' % line


def update():
    for index, line in enumerate(lines):
        # Remove '\n' character
        line = line[:-1]

        # Skip empty lines
        if len(line) == 0:
            continue

        # Check if we need to set SHA1 hash for the next files
        if line[0] == '#':
            needSHA1 = (' - from' in line)
            continue

        if needSHA1:
            # Remove existing SHA1 hash
            line = line.split('|')[0]
            filePath = line.split(':')[1] if len(line.split(':')) == 2 else line

            if filePath[0] == '-':
                file = open('%s/%s' % (vendorPath, filePath[1:]), 'rb').read()
            else:
                file = open('%s/%s' % (vendorPath, filePath), 'rb').read()

            hash = sha1(file).hexdigest()
            lines[index] = '%s|%s\n' % (line, hash)


if len(sys.argv) == 2 and sys.argv[1] == '-c':
    cleanup()
else:
    update()

with open(target_file, 'w') as file:
    for line in lines:
        file.write(line)

    file.close()
