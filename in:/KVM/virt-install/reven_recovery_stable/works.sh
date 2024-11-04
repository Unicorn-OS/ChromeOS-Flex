img=chromeos_14989.86.0_reven_recovery_stable-channel_mp-v2.bin
path=~/.uni/os/iso/$img
osinfo="--osinfo detect=on,require=off"
install_method="--import"

virt-install -n vm --description "Test VM with Chrome OS Flex" --osinfo=generic --import --ram=4096 --vcpus=4 --check path_in_use=off --livecd --boot hd --disk $path --video virtio --channel spicevmc --network default

# Solution:
#https://www.reddit.com/r/ChromeOSFlex/comments/yeejxd/comment/ka5cf5f/
#>Just add the --import option and you should be done.
