#/usr/bin/env bash

INTERVAL=1
TIMES=5
DISKS_TO_SLEEP=(
    "hdd-lvraid"
)
sync
for disk in ${DISKS_TO_SLEEP[@]}; do
    DISK_IO=$(atop -P LVM $INTERVAL $TIMES | grep 'hdd-lvraid' | gawk 'NR!=1 {s+=$8} END {if (s>0) print s}')
    if [[ -z "$DISK_IO" ]]; then
        echo "Putting disk $disk to sleep"
        sync
        hdparm -y $(lvdisplay -m /dev/mapper/$disk | grep -oE '\/dev/sd.?' | sort -u)
    fi
done