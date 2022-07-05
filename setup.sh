#/usr/bin/env bash

sudo cp bin/disksleeper.sh /usr/local/bin/

sudo mkdir -p /usr/local/lib/systemd/system/
sudo cp -r systemd/system/ /usr/local/lib/systemd/system/