#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
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

# WiMAX Support Note: All WiMAX framework and library proprietary blobs
# needed for this build are available at
# http://code.google.com/android/nexus/drivers.html#crespo4g

DEVICE=epicmtd

rm -rf ../../../vendor/samsung/$DEVICE/*
mkdir -p ../../../vendor/samsung/$DEVICE/proprietary

if [ -f "$1" ]; then
	rm -rf tmp
	mkdir tmp
	unzip -q "$1" -d tmp
	if [ $? != 0 ]; then
		echo "$1 is not a valid zip file. Bye."
		exit 1
	fi
	echo "$1 successfully unzip'd. Copying files..."
	ZIP="true"
else
	unset ZIP
fi

DIRS="
vendor/bin
bin
etc/wifi
lib/egl
lib/hw
media
firmware
vendor/firmware
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
bin/BCM4329B1_002.002.023.0746.0832.hcd

etc/wifi/nvram_net.txt

bin/rild
lib/libril.so
lib/libsec-ril40.so
lib/libsecril-client.so

etc/gps.conf
vendor/bin/gpsd
lib/hw/gps.s5pc110.so

vendor/bin/pvrsrvinit
vendor/lib/egl/libEGL_POWERVR_SGX540_120.so
lib/egl/libGLES_android.so
vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so
vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so
vendor/lib/libsrv_um.so
vendor/lib/libsrv_init.so
vendor/lib/libIMGegl.so
vendor/lib/libpvr2d.so
vendor/lib/libpvrANDROID_WSEGL.so
vendor/lib/libglslcompiler.so
vendor/lib/libPVRScopeServices.so
vendor/lib/libusc.so
vendor/firmware/samsung_mfc_fw.bin
firmware/CE147F00.bin
firmware/CE147F01.bin
firmware/CE147F02.bin
firmware/CE147F03.bin
vendor/firmware/CE147F02.bin
cameradata/datapattern_420sp.yuv
cameradata/datapattern_front_420sp.yuv

bin/geomagneticd
bin/orientationd
lib/libsensor_yamaha_test.so
lib/hw/sensors.s5pc110.so

lib/hw/copybit.s5pc110.so
vendor/lib/hw/gralloc.s5pc110.so

etc/wimax_boot.bin
etc/wimaxfw.bin
etc/wimaxloader.bin
vendor/lib/libSECmWiMAXcAPI.so
lib/libWiMAXNative.so
vendor/lib/wimax_service.jar

bin/playlpm
bin/charging_mode
lib/libQmageDecoder.so
media/battery_charging_5.qmg
media/battery_charging_10.qmg
media/battery_charging_15.qmg
media/battery_charging_20.qmg
media/battery_charging_25.qmg
media/battery_charging_30.qmg
media/battery_charging_35.qmg
media/battery_charging_40.qmg
media/battery_charging_45.qmg
media/battery_charging_50.qmg
media/battery_charging_55.qmg
media/battery_charging_60.qmg
media/battery_charging_65.qmg
media/battery_charging_70.qmg
media/battery_charging_75.qmg
media/battery_charging_80.qmg
media/battery_charging_85.qmg
media/battery_charging_90.qmg
media/battery_charging_95.qmg
media/battery_charging_100.qmg
media/chargingwarning.qmg
media/Disconnected.qmg
"

for FILE in $FILES; do
	if [ "$ZIP" ]; then
		cp tmp/system/"$FILE" ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	else
		adb pull system/$FILE ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	fi
done

adb pull system/app/SprintMenu.apk ../../../vendor/samsung/$DEVICE/proprietary/SprintMenu.apk
adb pull system/app/SystemUpdateUI.apk ../../../vendor/samsung/$DEVICE/proprietary/SystemUpdateUI.apk
adb pull system/app/WiMAXSettings.apk ../../../vendor/samsung/$DEVICE/proprietary/WiMAXSettings.apk
adb pull system/app/WiMAXHiddenMenu.apk ../../../vendor/samsung/$DEVICE/proprietary/WiMAXHiddenMenu.apk

if [ "$ZIP" ]; then rm -rf tmp ; fi

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/samsung/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
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

# This file is generated by device/samsung/__DEVICE__/extract-files.sh

#
# prelink
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:obj/lib/libsecrilclient.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:obj/lib/libsec-ril40.so

#
# Wifi
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/etc/wifi/nvram_net.txt:system/etc/wifi/nvram_net.txt


#
# Display (3D)
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLES_android.so:system/lib/egl/libGLES_android.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/hw/gralloc.s5pc110.so:system/vendor/lib/hw/gralloc.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libglslcompiler.so:system/vendor/lib/libglslcompiler.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libsrv_init.so:system/vendor/lib/libsrv_init.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libsrv_um.so:system/vendor/lib/libsrv_um.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libusc.so:system/vendor/lib/libusc.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/bin/pvrsrvinit:system/vendor/bin/pvrsrvinit \\
    vendor/samsung/__DEVICE__/proprietary/vendor/firmware/samsung_mfc_fw.bin:system/vendor/firmware/samsung_mfc_fw.bin \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so:system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so:system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so:system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libIMGegl.so:system/vendor/lib/libIMGegl.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libPVRScopeServices.so:system/vendor/lib/libPVRScopeServices.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libpvr2d.so:system/vendor/lib/libpvr2d.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libpvrANDROID_WSEGL.so:system/vendor/lib/libpvrANDROID_WSEGL.so \\
    vendor/samsung/__DEVICE__/proprietary/firmware/CE147F00.bin:system/firmware/CE147F00.bin \\
    vendor/samsung/__DEVICE__/proprietary/firmware/CE147F01.bin:system/firmware/CE147F01.bin \\
    vendor/samsung/__DEVICE__/proprietary/firmware/CE147F02.bin:system/firmware/CE147F02.bin \\
    vendor/samsung/__DEVICE__/proprietary/firmware/CE147F03.bin:system/firmware/CE147F03.bin \\
    vendor/samsung/__DEVICE__/proprietary/vendor/firmware/CE147F02.bin:system/vendor/firmware/CE147F02.bin \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv 
#
# Sensors, Lights etc
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/geomagneticd:system/bin/geomagneticd \\
    vendor/samsung/__DEVICE__/proprietary/bin/orientationd:system/bin/orientationd \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/sensors.s5pc110.so:system/lib/hw/sensors.s5pc110.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsensor_yamaha_test.so:system/lib/libsensor_yamaha_test.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/copybit.s5pc110.so:system/lib/hw/copybit.s5pc110.so

#
# Bluetooth
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/BCM4329B1_002.002.023.0746.0832.hcd:system/bin/BCM4329B1_002.002.023.0746.0832.hcd

#
# RIL
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/rild:system/bin/rild \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsec-ril40.so:system/lib/libsec-ril40.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/libril.so:system/lib/libril.so

#
# GPS
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/vendor/bin/gpsd:system/vendor/bin/gpsd \\
    vendor/samsung/__DEVICE__/proprietary/etc/gps.conf:system/etc/gps.conf \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gps.s5pc110.so:system/lib/hw/gps.s5pc110.so

#
# WiMAX
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/libWiMAXNative.so:system/lib/libWiMAXNative.so \\
    vendor/samsung/__DEVICE__/proprietary/etc/wimaxfw.bin:system/etc/wimaxfw.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wimaxloader.bin:system/etc/wimaxloader.bin \\
    vendor/samsung/__DEVICE__/proprietary/etc/wimax_boot.bin:system/etc/wimax_boot.bin \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/libSECmWiMAXcAPI.so:system/vendor/lib/libSECmWiMAXcAPI.so \\
    vendor/samsung/__DEVICE__/proprietary/vendor/lib/wimax_service.jar:system/vendor/lib/wimax_service.jar \\
    vendor/samsung/__DEVICE__/proprietary/WiMAXSettings.apk:system/app/WiMAXSettings.apk \\
    vendor/samsung/__DEVICE__/proprietary/SprintMenu.apk:system/app/SprintMenu.apk \\
    vendor/samsung/__DEVICE__/proprietary/WiMAXHiddenMenu.apk:system/app/WiMAXHiddenMenu.apk \\
    vendor/samsung/__DEVICE__/proprietary/SystemUpdateUI.apk:system/app/SystemUpdateUI.apk
    

PRODUCT_PACKAGES += \\
                WiMAXSettings \\
                SprintMenu \\
                WiMAXHiddenMenu \\
                SystemUpdateUI

DEVICE_PACKAGE_OVERLAYS := device/samsung/__DEVICE__/overlay

#
# Files for battery charging screen
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/playlpm:system/bin/playlpm \\
    vendor/samsung/__DEVICE__/proprietary/bin/charging_mode:system/bin/charging_mode \\
    vendor/samsung/__DEVICE__/proprietary/lib/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_5.qmg:system/media/battery_charging_5.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_10.qmg:system/media/battery_charging_10.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_15.qmg:system/media/battery_charging_15.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_20.qmg:system/media/battery_charging_20.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_25.qmg:system/media/battery_charging_25.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_30.qmg:system/media/battery_charging_30.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_35.qmg:system/media/battery_charging_35.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_40.qmg:system/media/battery_charging_40.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_45.qmg:system/media/battery_charging_45.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_50.qmg:system/media/battery_charging_50.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_55.qmg:system/media/battery_charging_55.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_60.qmg:system/media/battery_charging_60.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_65.qmg:system/media/battery_charging_65.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_70.qmg:system/media/battery_charging_70.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_75.qmg:system/media/battery_charging_75.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_80.qmg:system/media/battery_charging_80.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_85.qmg:system/media/battery_charging_85.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_90.qmg:system/media/battery_charging_90.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_95.qmg:system/media/battery_charging_95.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_100.qmg:system/media/battery_charging_100.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/chargingwarning.qmg:system/media/chargingwarning.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/Disconnected.qmg:system/media/Disconnected.qmg

EOF

./setup-makefiles.sh
