$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

DEVICE_PACKAGE_OVERLAYS += device/lge/msm7x27a-common/overlay

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    $(LOCAL_PATH)/configs/AudioFilter.csv:system/etc/AudioFilter.csv \
    $(LOCAL_PATH)/configs/vold.fstab:system/etc/vold.fstab

# BT
ifeq ($(BOARD_HAVE_BLUETOOTH_BLUEZ),true)
PRODUCT_COPY_FILES += \
    system/bluetooth/data/audio.conf:system/etc/bluetooth/audio.conf \
    system/bluetooth/data/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    system/bluetooth/data/blacklist.conf:system/etc/bluetooth/blacklist.conf \
    system/bluetooth/data/input.conf:system/etc/bluetooth/input.conf \
    system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf \
    system/bluetooth/data/network.conf:system/etc/bluetooth/network.conf \
    system/bluetooth/data/stack.conf:system/etc/bluetooth/stack.conf
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/audio_policy.conf::system/etc/audio_policy.conf

$(call inherit-product, build/target/product/full.mk)

# Permission files
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.google.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

PRODUCT_PACKAGES += \
    lgapversion

PRODUCT_PACKAGES += \
    init.lge-shared.rc \
    init.target.rc \
    init.lge.usb.rc \
    fstab.lproj \
    init.lproj.bt.sh \
    hcidump.sh \
    init.qcom.post_boot.sh \
    init.qcom.efs.sync.sh

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# display HALS
PRODUCT_PACKAGES += \
    libgenlock \
    liboverlay \
    libtilerenderer \
    gralloc.msm7x27a \
    copybit.msm7x27a \
    libqdMetaData

ifeq ($(BOARD_HAVE_BLUETOOTH_BLUEZ),true)
PRODUCT_PACKAGES += \
    bluetoothd \
    libbluetoothd \
    hcitool \
    hciconfig \
    hciattach \
    javax.btobex
endif

# off-mode charging
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Omx
PRODUCT_PACKAGES += \
    libmm-omxcore \
    libOmxCore \
    libstagefrighthw \
    libdashplayer \
    qcmediaplayer

# NFC packages
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

# Gps hal
PRODUCT_PACKAGES += \
    gps.msm7x27a

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    e2fsck \
    setup_fs

# Misc
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# audio 
PRODUCT_PACKAGES += \
    libaudioutils \
    audio.a2dp.default \
    audio.primary.msm7x27a \
    audio_policy.msm7x27a \
    audio.usb.default

ifeq ($(TARGET_USES_JELLYBEAN_BASEBAND),true)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.apm_sim_not_pwdn=1 \
    ro.telephony.ril.v3=qcomdsds
endif

# Ril sends only one RIL_UNSOL_CALL_RING, so set call_ring.multiple to false
PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.call_ring.multiple=0

PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.ril_class=LGEQualcommUiccRI

PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.default_network=0 \
	telephony.lteOnGsmDevice=0

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libril-qc-1.so \
    rild.libargs=-d/dev/smd0 \
    persist.rild.nitz_plmn= \
    persist.rild.nitz_long_ons_0= \
    persist.rild.nitz_long_ons_1= \
    persist.rild.nitz_long_ons_2= \
    persist.rild.nitz_long_ons_3= \
    persist.rild.nitz_short_ons_0= \
    persist.rild.nitz_short_ons_1= \
    persist.rild.nitz_short_ons_2= \
    persist.rild.nitz_short_ons_3= \
    ril.subscription.types=NV,RUIM \
    DEVICE_PROVISIONED=1 \
    keyguard.no_require_sim=1 

PRODUCT_PROPERTY_OVERRIDES += \
    ro.qualcomm.bt.hci_transport=uart

# Common properties
PRODUCT_PROPERTY_OVERRIDES += \
    debug.fb.rgb565=0 \
    debug.sf.hw=1 \
    debug.composition.type=mdp \
    ro.opengles.version=131072 \
    com.qc.hardware=true \
    persist.sys.use_dithering=1 \
    hwui.render_dirty_regions=false \
    wifi.interface=wlan0 \
    ro.adb.secure=0 \
    persist.sys.usb.config=mtp,adb \
    persist.service.adb.enable=1 \
    ro.debuggable=1 \
    hwui.render_dirty_regions=true \
    ro.max.fling_velocity=4000 \
    sys.mem.max_hidden_apps=10 \
    debug.camcorder.disablemeta=1

# Enable Torch
PRODUCT_PACKAGES += Torch

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_MANUFACTURER := LGE
PRODUCT_BRAND := lge
