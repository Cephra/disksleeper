#/usr/bin/env bash

sudo cp disksleeper.sh /usr/local/bin/

sudo mkdir -p /usr/local/lib/systemd/system
sudo cp ../systemd/system/* /usr/local/lib/systemd/system