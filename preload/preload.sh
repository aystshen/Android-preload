#!/system/bin/sh

PRELOAD_SOURCE=/system/preload
SDCARD_PATH=/sdcard
PRELOAD_DEST=${SDCARD_PATH}
PRELOAD_FLAG=${PRELOAD_DEST}/.preload

while [ ! -d ${SDCARD_PATH}/Android ] ; do
    echo "preload: ${SDCARD_PATH}/Android no exist and wait 3s."
    sleep 3
done

rm -rf ${SDCARD_PATH}/LOST.DIR/*

if [ ! -d ${PRELOAD_SOURCE} ]
then
    echo "${PRELOAD_SOURCE} not exist!"
    exit 0
fi

if [ ! -d ${PRELOAD_DEST} ]
then
    mkdir -p ${PRELOAD_DEST}
fi

old_version=`grep "ro.topband.sw.versioncode" ${PRELOAD_FLAG}`
cur_version=`grep "ro.topband.sw.versioncode" /system/build.prop`
if [ ! $cur_version ]; then
    cur_version=`grep "ro.topband.sw.versioncode" /vendor/build.prop`
fi
echo "preload: old_version=${old_version}, cur_version=${cur_version}"

if [ "${cur_version}" != "${old_version}" ]
then
    cp -vrf ${PRELOAD_SOURCE}/* ${PRELOAD_DEST}/
    echo "${cur_version}" > ${PRELOAD_FLAG}
else
    echo "Not new version, don't copy preload files!!!"
fi

exit 0