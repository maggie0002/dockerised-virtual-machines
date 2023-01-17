#!/usr/bin/env bash
chown root:kvm /dev/kvm

service libvirtd start
service virtlogd start
vagrant up

RDP_OUT="$(vagrant rdp --machine-readable)"
RDP_IP=$(echo "$RDP_OUT" | grep "Address:.*" -o)
RDP_USERNAME=$(echo "$RDP_OUT" | grep "Username:.*" -o)

echo RDP service running:
echo "$RDP_IP"
echo "$RDP_USERNAME"

exec "$@"
