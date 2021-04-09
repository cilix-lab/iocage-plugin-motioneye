#!/bin/sh

# Install Python 2.7 and Mosquitto (for mosquitto_pub)
env ASSUME_ALWAYS_YES=YES pkg install python2 mosquitto

# Create symlinks for python
ln -s /usr/local/bin/python2.7 /usr/local/bin/python2
ln -s /usr/local/bin/python2.7 /usr/local/bin/python

# Install legacy py27-pip
fetch https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python get-pip.py

# Create symlinks for pip
ln -s /usr/local/bin/pip2.7 /usr/local/bin/pip-2.7

# Create symlink for sha1sum to allow file uploading to function
ln -s /usr/local/bin/shasum /usr/local/bin/sha1sum

# Install motioneye
pip-2.7 install motioneye

# Enable motioneye
sysrc -f /etc/rc.conf motioneye_enable="YES"

# Create folders
mkdir -p /usr/local/etc/motioneye /var/lib/motioneye

# Get initial configuration
cp /usr/local/share/motioneye/extra/motioneye.conf.sample /usr/local/etc/motioneye/motioneye.conf
sed -i.old 's|^conf_path .*|conf_path /usr/local/etc/motioneye|' /usr/local/etc/motioneye/motioneye.conf
sed -i.old 's|^log_path .*|log_path /var/log/motioneye|' /usr/local/etc/motioneye/motioneye.conf
sed -i.old 's|^run_path |#run_path |' /usr/local/etc/motioneye/motioneye.conf
rm -f /usr/local/etc/motioneye/motioneye.conf.old

# Create motioneye user and group
pw useradd -q -n motioneye -u 8765 -d /nonexistent -m
rm -rf /nonexistent
chown -R motioneye:motioneye /usr/local/etc/motioneye /var/lib/motioneye

# Start the service
service motioneye start

exit 0
