#
# Copyright (C) 2011 The Android Open Source Project
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

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.


DEVICE_PACKAGE_OVERLAYS := device/samsung/epicmtd/overlay


# These are the hardware-specific configuration files
PRODUCT_COPY_FILES := \
    device/samsung/epicmtd/prebuilt/etc/asound.conf:system/etc/asound.conf \
    device/samsung/epicmtd/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/samsung/epicmtd/prebuilt/etc/egl.cfg:system/lib/egl/egl.cfg

# Init files
PRODUCT_COPY_FILES += \
  device/samsung/epicmtd/ueventd.victory.rc:root/ueventd.victory.rc \
  device/samsung/epicmtd/lpm.rc:root/lpm.rc \
  device/samsung/epicmtd/init.victory.rc:root/init.victory.rc \
  device/samsung/epicmtd/init.victory.usb.rc:root/init.victory.usb.rc

# RIL
PRODUCT_COPY_FILES += \
     device/samsung/epicmtd/prebuilt/bin/pppd_runner:system/bin/pppd_runner \
     device/samsung/epicmtd/prebuilt/etc/ppp/ip-up:system/etc/ppp/ip-up
FRAMEWORKS_BASE_SUBDIRS += ../../$(LOCAL_PATH)/epicril/

# WiFi
PRODUCT_COPY_FILES += \
     device/samsung/epicmtd/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Keylayout and Keychars
PRODUCT_COPY_FILES += \
     device/samsung/epicmtd/prebuilt/usr/keylayout/cypress-touchkey.kl:system/usr/keylayout/cypress-touchkey.kl \
     device/samsung/epicmtd/prebuilt/usr/keychars/cypress-touchkey.kcm:system/usr/keychars/cypress-touchkey.kcm \
     device/samsung/epicmtd/prebuilt/usr/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
     device/samsung/epicmtd/prebuilt/usr/keychars/s3c-keypad.kcm:system/usr/keychars/s3c-keypad.kcm \
     device/samsung/epicmtd/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
     device/samsung/epicmtd/prebuilt/usr/keychars/sec_jack.kcm:system/usr/keychars/sec_jack.kcm \
     device/samsung/epicmtd/prebuilt/usr/keylayout/victory-keypad.kl:system/usr/keylayout/victory-keypad.kl \
     device/samsung/epicmtd/prebuilt/usr/keychars/victory-keypad.kcm:system/usr/keychars/victory-keypad.kcm \
     device/samsung/epicmtd/prebuilt/usr/idc/qt602240_ts_input.idc:system/usr/idc/qt602240_ts_input.idc

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	device/samsung/epicmtd/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core.s5pc110 \
    libOMX.SEC.AVC.Decoder.s5pc110 \
    libOMX.SEC.M4V.Decoder.s5pc110 \
    libOMX.SEC.M4V.Encoder.s5pc110 \
    libOMX.SEC.AVC.Encoder.s5pc110

# Libs
PRODUCT_PACKAGES += \
    lights.s5pc110 \
    audio.primary.s5pc110 \
    audio_policy.s5pc110 \
    audio.a2dp.default \
    hwcomposer.s5pc110 \
    sensors.s5pc110 \
    libstagefrighthw

# update utilities
PRODUCT_PACKAGES += \
	bml_over_mtd \
	setup_fs

# Bluetooth MAC Address
PRODUCT_PACKAGES += \
	bdaddr_read

# Camera
PRODUCT_PACKAGES += \
    libs3cjpeg \
    camera.s5pc110

# tvout 
PRODUCT_PACKAGES += \
	tvouthack

# Device-specific packages
PRODUCT_PACKAGES += \
	EpicParts

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
#camera profile
PRODUCT_COPY_FILES += \
    device/samsung/epicmtd/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# Enable "Android debugging" in Settings menu.
# Enable USB mass storage (and adb) at boot.
PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mass_storage

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# Telephony property for CDMA
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.vc_call_vol_steps=15 \
    ro.telephony.default_network=4 \
    ro.com.google.clientidbase=android-sprint-us \
    ro.cdma.home.operator.numeric=310120 \
    ro.cdma.home.operator.alpha=Sprint \
    net.cdma.pppd.authtype=require-pap \
    net.cdma.pppd.user=user[SPACE]SprintNextel \
    net.interfaces.defaultroute=cdma \
    net.connectivity.type=CDMA1 \
    mobiledata.interfaces=ppp0,uwbr0 \
    ro.telephony.ril_class=EpicRIL \
    ro.telephony.ril.v3=datacall \
    ro.ril.samsung_cdma=true

# WiMAX Property setting for checking WiMAX interface
PRODUCT_PROPERTY_OVERRIDES += \
    ro.wimax.interface=uwbr0 \
    net.tcp.buffersize.wimax=4092,87380,1520768,4092,16384,1520768

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
       wifi.interface=eth0 \
       wifi.supplicant_scan_interval=20

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
        ro.com.google.locationfeatures=1 \
        ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false
# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    device/samsung/epicmtd/recovery.bin:recovery.bin

# dalvik.vm.heapstartsize=5m
# dalvik.vm.heapgrowthlimit=48m
# dalvik.vm.heapsize=128m
$(call inherit-product, frameworks/base/build/phone-hdpi-512-dalvik-heap.mk)

# copy the filesystem converter
PRODUCT_COPY_FILES += \
  device/samsung/epicmtd/updater.sh:updater.sh

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/epicmtd/epicmtd-vendor.mk)
