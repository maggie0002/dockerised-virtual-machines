# Start Ubuntu and Windows Virtual Machines on supported hardware (WIP)

Works with balenaOS Intel Nuc Generic Images. Docker images can be run as follows:

```bash
docker run --privileged -it --network host --device=/dev/kvm --device=/dev/net/tun -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cap-add=NET_ADMIN --cap-add=SYS_ADMIN test
docker run --privileged -it --network host --device=/dev/kvm --device=/dev/net/tun -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cap-add=NET_ADMIN --cap-add=SYS_ADMIN windowskvm
```

When running Windows, be sure to login and disable the sleep and hibernation modes.

Windows will still occasionally sleep as part of its Windows 10 quick start mode. To restore the session, connect to the container and run:

```bash
vagrant resume
```

Similarly, VMs can be suspended to prevent using more resources than required:

```bash
vagrant suspend
```

It can then be resumed manually by connecting to the container and running:

```bash
vagrant resume
```

For Ubuntu, install RDP by ssh into the container and running:

```bash
sudo apt update
sudo apt install xrdp
sudo adduser xrdp ssl-cert
sudo systemctl restart xrdp
```
