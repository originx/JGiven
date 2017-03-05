#!/bin/bash
# Script adb+
# Usage
# You can run any command adb provides on all your currently connected devices
# ./adb+ <command> is the equivalent of ./adb -s <serial number> <command>
#
# Examples
# ./adb+ version
# ./adb+ install apidemo.apk
# ./adb+ uninstall com.example.android.apis
destination="build/reports/jgiven/json"
for line in `adb devices | grep -v "List"  | awk '{print $1}'`
do
  device=`echo $line | awk '{print $1}'`
  echo "$device $@ ..."
        mkdir -p "./devices/$device"
        echo "$device $@ ..."
        storage=$(adb -s "$device" shell 'echo $EXTERNAL_STORAGE')
        storage="$storage"/Download/jgiven-reports/
        echo $storage
        adb -s "$device" pull /"$storage"/ "$destination/$device/"
        adb -s "$device" shell rm -rf /"$storage"
done
