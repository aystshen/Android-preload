###############################################################################
# preload

LOCAL_PATH := vendor/rockchip/common/preload
PRODUCT_COPY_FILES += $(LOCAL_PATH)/preload/.preload:system/preload/.preload

PRODUCT_PACKAGES += preload.sh