#!/bin/dash
{
	# Error out on command failures
	set -e

	REFLASH_PATH=$(sed -n '/^[[:blank:]]*AUTO_SETUP_FLASH_OS=/{s/^[^=]*=//p;q}' /boot/dietpi.txt)

	mount -ro remount /
	echo '[ OK ] Mounted RootFS as read-only'
	dd if=$(findmnt -Ufnro SOURCE -M /) of="$REFLASH_PATH" status=progress
	echo "[ OK ] Flashed DietPi to $REFLASH_PATH"
	echo 'DietPi will reboot in 10 seconds, please remove your installation media'
	sleep 10
	reboot
}
