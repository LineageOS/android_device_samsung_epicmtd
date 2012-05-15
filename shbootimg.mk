LOCAL_PATH := $(call my-dir)

# Wifi module symlink
WIFI_MODULE := bcm4329.ko

WIFI_SYMLINK := $(PRODUCT_OUT)/root/lib/modules/$(WIFI_MODULE)
$(WIFI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Symlink: $@ -> $(WIFI_MODULE)"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/lib/modules/$(WIFI_MODULE) $@

$(INSTALLED_RAMDISK_TARGET): $(WIFI_SYMLINK)

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
$(INSTALLED_BOOTIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(recovery_ramdisk) $(INSTALLED_RAMDISK_TARGET)  $(PRODUCT_OUT)/utilities/erase_image $(PRODUCT_OUT)/utilities/flash_image $(PRODUCT_OUT)/utilities/busybox $(PRODUCT_OUT)/utilities/make_ext4fs
	$(call pretty,"Boot image: $@")
	$(hide) ./device/samsung/epicmtd/mkshbootimg.py $@ $(PRODUCT_OUT)/kernel $(INSTALLED_RAMDISK_TARGET) $(recovery_ramdisk)

$(INSTALLED_RECOVERYIMAGE_TARGET): $(INSTALLED_BOOTIMAGE_TARGET)
	$(ACP) $(INSTALLED_BOOTIMAGE_TARGET) $@
