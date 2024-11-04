on Login Screen:  
`<Ctrl> + <Alt> + F2`

localhost login:  
`root`

show disks:  
`lsblk -e7`

then:
```
disk_name=sda
sudo chromeos-install -dst /dev/$disk_name
```
