#!/system/bin/sh

PRELOAD_SOURCE=/system/preload
SDCARD_PATH=/mnt/internal_sd
PRELOAD_DEST=${SDCARD_PATH}/preload
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

OLD_VERSION=`grep "ro.topband.sw.versioncode" ${PRELOAD_FLAG}`
CUR_VERSION=`grep "ro.topband.sw.versioncode" /system/build.prop`
echo "preload: OLD_VERSION=${OLD_VERSION}, CUR_VERSION=${CUR_VERSION}"

if [ "${CUR_VERSION}" != "${OLD_VERSION}" ]
then
	rm -rf ${PRELOAD_DEST}/*
	cp -vrf ${PRELOAD_SOURCE}/* ${PRELOAD_DEST}/
    echo "${CUR_VERSION}" > ${PRELOAD_FLAG}
else
	echo "Not new version, don't copy preload files!!!"
fi

exit 0