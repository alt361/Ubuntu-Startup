#!/bin/bash

# variable
declare subs
subs="30 *   * * * root		cp /mnt/c/Users/roamy/Temp/* /mnt/f/log/ && rm -rf /mnt/c/Users/roamy/Temp/* /etc/crontab"

# had to be root to use the following commands
systemctl enable systemd-networkd
sudo su root

# apt database update
apt update 1>/dev/null 2>/dev/null && apt upgrade 1>/dev/null 2>/dev/null
apt install tree plocate xd smartmontools -y

cd /
clear

# edit of the terminal properties
tee -a /etc/bash.bashrc 1>/dev/null << EOF
if ! -e /mnt/f; then
	mkdir /mnt/f
	chmod -R 700 /mnt/f
fi
>>EOF

tee -a /home/roamy/.bashrc 1>/dev/null << EOF
if ! -e /mnt/f; then
	mkdir /mnt/f
	chmod -R 700 /mnt/f
fi
>> EOF

tee -a /home/root/.bashrc 1>/dev/null << EOF
if ! -e /mnt/f; then
	mkdir /mnt/f
	chmod -R 700 /mnt/f
fi
>> EOF

# acces to the an usb key
mount -t drvfs F: /mnt/f

# edit of files properties
grep -o linenumbers /etc/nanorc | sed -i -e "s/^#//" /etc/nanorc
grep -o "#" /etc/crontab | tail -1 | sed -i -e "s/#/$subs/"  /etc/crontab
grep -o "#force_color_prompt" /home/roamy/.bashrc | sed -e -i "s/#//" /home/roamy/.bashrc
grep -o "#force_color_prompt" /root/.bashrc | sed -e -t "s/#//" /root/.bashrc


