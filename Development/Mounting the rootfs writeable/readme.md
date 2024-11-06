# Guide:
- [Mounting the rootfs writeable](https://shibumi.dev/posts/enable-developer-mode-on-chrome-os-flex/#mounting-the-rootfs-writeable)

Quote:
>Developer mode alone might not be sufficient, because you want to very likely modify files. If you tried mounting the rootfs writeable, you might have realized that this does not work. This is because of dm-verity. For disabling dm-verity, you must run the following command on Chrome OS Flex and reboot: /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification --force --partition 2.
>
>The command can be destructive, so make sure to backup any meaningful data first. After a fresh reboot you should be able to do: sudo mount -o remount,rw /. This remounts your rootfs writeable and you can directly work on the rootfs. This comes very useful when you want to debug system internals or want more log data for preparing a bug report to the Google Chrome OS team.
