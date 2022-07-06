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
        echo "Spinning down $disk..."
        sync
        hdparm -y $(lsblk -nlpso NAME /dev/mapper/$disk | grep -oE '^.+?sd.?[^0-9]$')
        echo "...done"
    fi
done

