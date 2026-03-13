#!/bin/bash

#set -e #aborts script if command fails

if ! id -u ${FTP_USER} > /dev/null 2>&1; then #if user id not existing
    useradd -d /var/www/html ${FTP_USER} #create user to home (-m), '-d /var/.../html' -> to wordpress folder
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd # set password
    chown -R ${FTP_USER}:${FTP_USER} /var/www/html #grants FTP-user permission for all wordpress data -- recursivly to all subdirectories
fi

mkdir -p /var/run/vsftpd/empty

cat > /etc/vsftpd.conf <<EOF #create .conf, opens heredoc
listen=YES
listen_port=21
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=21100
pasv_max_port=21110
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
seccomp_sandbox=NO
EOF

echo "${FTP_USER}" > /etc/vsftpd.userlist # user put to white list - only he can login

echo "FTP server starting..."

vsftpd /etc/vsftpd.conf