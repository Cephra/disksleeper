#/usr/bin/env bash

INTERVAL=1
TIMES=30
LVS_TO_SLEEP=(
    "hdd-lvraid"
)
sync
for lvol in ${LVS_TO_SLEEP[@]}; do
    DISK_IO=$(atop -P LVM $INTERVAL $TIMES | grep "$lvol" | gawk 'NR!=1 {s+=$8} END {if (s>0) print s}')
    if [[ -z "$DISK_IO" ]]; then
        LV_DISKS=$(lsblk -nlpso NAME /dev/mapper/$lvol | grep -oE '^.+?sd.?[^0-9]$')
        for pdisk in ${LV_DISKS[@]}; do
            DISK_SPINNING=$(hdparm -C $pdisk | grep -oE 'standby')
            if [[ -z "$DISK_SPINNING" ]]; then
                sync
                hdparm -y $pdisk
            else
                echo 'no disks spinning'
            fi
        done
    fi
done

