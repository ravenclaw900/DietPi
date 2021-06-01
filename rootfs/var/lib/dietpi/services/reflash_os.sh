#!/bin/bash
{
	# Error out on command failures
	set -e

	# Load DietPi-Globals
    . /boot/dietpi/func/dietpi-globals
	readonly G_PROGRAM_NAME='DietPi-OS-Reflash'
	G_CHECK_ROOT_USER
	G_INIT

	REFLASH_PATH=$(sed -n '/^[[:blank:]]*AUTO_SETUP_FLASH_OS=/{s/^[^=]*=//p;q}' /boot/dietpi.txt)

	if G_WHIP_YESNO "Are you sure that you want to flash DietPi to $REFLASH_PATH? This will erase all data on that drive."
	then
		G_EXEC mount -ro remount /
		G_DIETPI-NOTIFY 0 'Mounted RootFS as read-only'
		G_DIETPI-NOTIFY -2 "Flashing DietPi to $REFLASH_PATH"
		G_EXEC dd if=$(findmnt -Ufnro SOURCE -M /) of="$REFLASH_PATH"
		G_DIETPI-NOTIFY 0 "Flashed DietPi to $REFLASH_PATH"
		G_WHIP_MSG 'Please remove your installation media, then press OK.'
		reboot
	fi
}
