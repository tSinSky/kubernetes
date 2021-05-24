# update dnf packages
dnf update -y
setenforce 0
swapoff -a

sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config
sed -i 's!/dev/mapper/ro_redos-swap!#/dev/mapper/ro_redos-swap!' /etc/fstab

echo "enter hostname"
read n
hostnamectl set-hostname $n
IP_addr=`hostname  -I | cut -f1 -d' '`
echo "$IP_addr  $n - write these variables? (y/n)"
read s
if [[ $s == 'y' ]]; then
  echo "$IP_addr  $n" >> /etc/hosts
else exit
fi

reboot
