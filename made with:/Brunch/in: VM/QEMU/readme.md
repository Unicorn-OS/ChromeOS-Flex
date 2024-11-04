# Discuss:
- [QEMU - How can I compile modules for KVM and what would be the best chromeos version for that? #1160](https://github.com/sebanc/brunch/issues/1160)

Works!

# Quote:
You can get the image for chromeos device hatch(this atm https://dl.google.com/dl/edgedl/chromeos/recovery/chromeos_14816.82.0_hatch_recovery_stable-channel_mp-v6.bin.zip) booting and show a somewhat functional ui in qemu, couldn't get the mouse working, but I just wanted to see how it boots the arcvm so I didn't try much.

Download the image, set it up with brunch like normal to a disk image. Then download the recovery image for reven/Chrome OS flex image (https://dl.google.com/dl/edgedl/chromeos/recovery/chromeos_14989.86.0_reven_recovery_stable-channel_mp-v2.bin.zip), then extract the mesa drivers from ROOT-A of the reven recovery image(folder /usr/lib64/dri and /usr/lib64/libdrm* files) put them in the same place in the ROOT-A of disk image you set up. Technically we only need the /usr/lib64/dri/virtio_gpu_dri.so but for some reason it depends on libraries for other gpus. I guess you could build mesa from the sources using a chromeos sysroot just for virtio_gpu too.

Now technically the image should boot it qemu with virtio-vga device(can use virtio-gpu-gl too but I had some graphics corruption), But for some reson, chromeos tries to start the ui before virtio-gpu dri interface is ready, I think it tries to use the efi vga device and then crashes, you can probably disable this mode in qemu but I didn't manage to get it working. So you have to enable the ssh server by mounting the ROOT-A of the brunch image, then chroot to it and set a root password by running passwd. Then enable sshd by cp /usr/share/chromeos-ssh-config/init/openssh-server.conf /etc/init. Now it'll run at boot. You just have to ssh into the VM and then run start ui. You might have the kill the updater service to stop it from updating at the first run.

Qemu command is

qemu-system-x86_64 -enable-kvm -m 8G -smp 4 -machine q35 -rtc base=utc -bios /usr/share/ovmf/OVMF.fd -boot menu=on,splash-time=5 -cpu host -net user,hostfwd=tcp::2222-:22 -net nic -display gtk,show-cursor=on -device virtio-vga -hda hatch.img
then ssh

ssh root@localhost -p 2222 -T
