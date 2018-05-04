# preload

此仓库解决Android内置文件问题，默认文件存在system/preload目录，此脚本开机启动将system/preload目录中文件copy到sdcard/preload目录。

## 使用
#### 1. 将preload目录copy至vendor/rockchip/common/下
```
shenhb@dqrd01:~/code/topband_rk3128/vendor/rockchip/common/preload$ tree
.
├── Android.mk
├── preload
│   └── README.md
├── preload.mk
└── preload.sh
```
#### 2. 修改device/rockchip/common/init.rockchip.rc，增加下面代码：
```
#preload
service preload /system/xbin/preload.sh
    class late_start
    user root
    group media_rw
    oneshot
```
#### 3. 修改vendor/rockchip/common/BoardConfigVendor.mk，增加下面代码：
```
PRODUCT_HAVE_PRELOAD ?= true
```
#### 4. 修改vendor/rockchip/common/device-vendor.mk，增加下面代码：
```
ifeq ($(PRODUCT_HAVE_PRELOAD),true)
$(call inherit-product-if-exists, vendor/rockchip/common/preload/preload.mk)
endif
```