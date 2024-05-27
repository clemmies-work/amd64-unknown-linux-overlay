# amd64-unknown-linux-overlay

overlay for stuff

## Mount rootfs

```bash
sudo mkdir -p /mnt/rootfs
sudo mount --type=squashfs --options=loop rootfs.sqsh /mnt/rootfs
```
