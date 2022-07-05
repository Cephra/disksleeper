#/usr/bin/env bash

DISKS_TO_SLEEP=(
    "hdd-lvraid"
)
#for disk in ${DISKS_TO_SLEEP[@]}; do
#    sync
#    hdparm -y $(lvdisplay -m /dev/mapper/${disk} | grep -oE '\/dev/sd.?' | sort -u)
#done