#!/bin/bash


# backupVM.bash
# Purpose: Backup VM images
#
# USAGE: ./vmarchiver
#
# Author: *** James Kapogiannis ***
# Date: *** 2023-10-28 ***

user=$(whoami)
if [ $user != "root" ] # only runs if using sudo or root
then
 echo "You must run this script with root privileges." >&2
 exit 1
fi

# variables for source path and packup path
img_path="/var/lib/libvirt/images/"
backup_path="/home/james/backups/"



# prompt the user to enter the name of the script they wish to backup, will loop until correct option is given
vmList=$(virsh list --all)

while true; do
	echo "Aviable VMs to create backups for, please ensure the VM is SHUTOFF before doing any backups:"
	echo "$vmList"
	read -p "Please enter the name of the VM you wish to create a backup for: " input

	if [[ "$vmList" =~ $input ]]; then
		vmName=$input
		break
	else
		echo "Please enter a valid VM name from the list provided above"
	fi
done

echo "You choose $vmName to create a backup for."

virsh dumpxml "$vmName" > "${backup_path}${vmName}-$(date +\%Y\%m\%d).xml"

grep '<source file=' "${backup_path}${vmName}.xml"

tar -cvzf "${backup_path}${vmName}.tar" "${vmName}.xml"
#tar -rvzf "${backup_path}${vmName}-$(date +\%Y\%m\%d).tar ${vmName}.qcow2
tar -cvzf "${backup_path}${vmName}-$(date +\%Y\%m\%d).tar.gz" "${vmName}.xml" "${img_path}${vmName}.qcow2"

gzip < "${backup_path}${vmName}-$(date +\%Y\%m\%d).tar > ${backup_path}${vmName}-$(date +\%Y\%m\%d).tar.gz"

echo "${vmName} BACKUP DONE"
