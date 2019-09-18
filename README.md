# Android-preload

This repository solves the problem of Android built-in files. The default file exists in the system/preload directory. This script starts and copies the files in the system/preload directory to the sdcard directory.

## Usage
1. Copy the preload directory to vendor/rockchip/common/.
```
shenhb@dqrd01:~/vendor/rockchip/common/preload$ tree
.
├── Android.mk
├── preload
├── preload.mk
└── preload.sh
```
2. Modify device/rockchip/common/init.rockchip.rc and add the following code:
```
#preload
service preload /system/xbin/preload.sh
    class late_start
    user root
    group media_rw
    oneshot
```
3. Modify vendor/rockchip/common/BoardConfigVendor.mk and add the following code:
```
PRODUCT_HAVE_PRELOAD ?= true
```
4. Modify vendor/rockchip/common/device-vendor.mk and add the following code:
```
ifeq ($(PRODUCT_HAVE_PRELOAD),true)
$(call inherit-product-if-exists, vendor/rockchip/common/preload/preload.mk)
endif
```

### For SEAndroid
1. Modify device/rockchip/common/init.rockchip.rc and add the following code:
```   
#preload
service preload /system/xbin/preload.sh
    class late_start
    user root
    group media_rw
    oneshot
```
2. Modify device/rockchip/common/sepolicy/file_contexts and add the following code:
```
# for preload
/system/xbin/preload.sh            u:object_r:preload_exec:s0
```
3. Modify device/rockchip/common/sepolicy/init.te and add the following code:
```
domain_trans(init, preload_exec, preload)
```
4. Add device/rockchip/common/sepolicy/preload.te file.
```
type preload, domain, coredomain, mlstrustedsubject;
type preload_exec, exec_type, vendor_file_type, file_type;
init_daemon_domain(preload)
```

## Developer
* ayst.shen@foxmail.com

## License
```
Copyright 2019 Bob Shen

Licensed under the Apache License, Version 2.0 (the "License"); you may 
not use this file except in compliance with the License. You may obtain 
a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the 
License for the specific language governing permissions and limitations 
under the License.
```
