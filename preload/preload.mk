###############################################################################
# preload

LOCAL_PATH := vendor/rockchip/common/preload
PRODUCT_COPY_FILES += $(LOCAL_PATH)/preload/README.md:system/preload/README.md

PRODUCT_PACKAGES += preload.sh