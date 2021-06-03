#!/bin/dash
{
	# Error out on command failures
	set -e

	REFLASH_PATH=$(sed -n '/^[[:blank:]]*AUTO_SETUP_FLASH_OS=/{s/^[^=]*=//p;q}' /boot/dietpi.txt)

	whiptail --yesno "Are you sure that you want to flash DietPi to $REFLASH_PATH? This will erase all data on that drive." 10 50 --title DietPi-OS-Reflash || exit 0
	mount -ro remount /
	echo '[ OK ] Mounted RootFS as read-only'
	dd if=$(findmnt -Ufnro SOURCE -M /) of="$REFLASH_PATH" status=progress
	echo "[ OK ] Flashed DietPi to $REFLASH_PATH"
	whiptail --msgbox "Please remove your installation media, then press 'Ok'." 10 50 --title DietPi-OS-Reflash 
	reboot
}
