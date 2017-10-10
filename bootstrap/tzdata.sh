#!/bin/sh

export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
echo "tzdata tzdata/Areas select Etc\n tzdata tzdata/Zones/Etc select UTC" > /tmp/tzdata-preseed.txt
debconf-set-selections /tmp/tzdata-preseed.txt
apt-get install -y tzdata
