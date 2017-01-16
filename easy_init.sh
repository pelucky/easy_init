#!/bin/bash

# Author: pelucky
# Date  : 2016.09.30
# Desc  : It is a simple system init script for CentOS6 and 7
# vers  : 1.1

OS_SYSTEM=
OS_SYSTEM_VERSION=
HOSTNAME_FILE=/etc/hostname
HOSTNAME=
SEARCH=hzzhd.wj
DNSSERVER1=18.18.96.10
DNSSERVER2=18.18.96.3
DNSSERVER_FILE=/etc/resolv.conf
SA_USER1=pel
SA_USER2=zjna
SA_USER1_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArltXg+uI5lnhcUjd2wUM1nOzZRqCOzhwPDNJjcFc2uXxY0zBKMJ13Tx8tEwsHxR5UJEC1RBNCaXnCUxXB2EZ3RcZPowS1Xa1Cf+WJPR0Ot7n9FU2E01VhHz6GWjb0C5gGS1EVXKxfFXhJIXRxxJBij7Yx34XouTYEIo5IfqYFnrHG9ms3IFE2oWV1umTA/5dCP1OgdBEIl71wwarHYWYt0NMsYz/2kE5a4pOhVsd6oySTV9UFsUSeHvESBR1T+gf3KyvEh7iAhoSIF5b6C4cd+H7aswRsOHCyNhvIrlRYObzB+WDZ31Q5CFk/xkDTttdnXgfzWZRag+d9Ma3NDpc4Q=="
SA_USER2_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAuDJFLBOuyZh1E24kNhBP/NiUHjZUKccEkmMZtuGzOXfGvczSGhedCGtMhzG4sr3WZimSoX7gMpMpFM1gN2P4i4RnuavwUhpWM3Hi1s9Yf+EkmUTP5YXwRUlVrq0ULVpxmzbZzd7QA33Szd096ks+J1b21Xpvr5imwRXwveblGCmR5K58RWeofmsNME7R0Rc5/cjUdEwMjf6+z48R4wcbm4pMQZ2GGFkZ1Vw81OA8yufaH5f5B9A3pN3noPH2MyrI8MhoZ2nJsp9hUdNbJA1rBQyGSJaQRdOGKLkbqJ7xXL8Iwd52Xh+1AR0VS3Koherc0S/iWmhAtyPf/kzVnt4C4Q=="
SSHD_CONFIG_FILE=/etc/ssh/sshd_config
YUM_FILE=/etc/yum.repos.d/CentOS-Base.repo
CENTOS7_YUM="[http-yum-new]
name=http yum new
baseurl=http://18.18.96.3/centos/7/os_new/x86_64/
enabled=1
gpgcheck=0

[http-yum-extras]
name=http yum extras
baseurl=http://18.18.96.3/centos/7/extras/x86_64/
enabled=1
gpgcheck=0

[Openstack-Newton-7-yum]
name=openstack newton
baseurl=http://18.18.96.3/centos/7/cloud/x86_64/openstack-newton/
enabled=1
gpgcheck=0"
CENTOS6_YUM="[base]
name=myrepo
baseurl=http://18.18.96.10/yum/CentOS-6.5/Packages
enabled=1
gpgcheck=0

#release updates
[updates]
name=myrepo
baseurl=http://18.18.96.10/yum/CentOS-6.5/Packages
gpgcheck=1
enabled=1
gpgcheck=0

#packages used/procduced in the build but not released
[addons]
name=myrepo
baseurl=http://18.18.96.10/yum/CentOS-6.5/Packages
enabled=1
gpgcheck=0

#additional packages that may be useful
[extras]
name=myrepo
baseurl=http://18.18.96.10/yum/CentOS-6.5/Packages
enabled=1
gpgcheck=0
"
ROOT_VIMRC_FILE=/root/.vimrc
VIMRC_CONFIG="set number
syntax on
syntax enable
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul
set cursorline

set ruler
set showcmd
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set autoindent
set confirm
set nocompatible
set nopaste
set foldenable
"
SSHD_CONFIG="HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
SyslogFacility AUTHPRIV
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile  .ssh/authorized_keys
PasswordAuthentication yes
ChallengeResponseAuthentication no
GSSAPIAuthentication yes
GSSAPICleanupCredentials yes
UsePAM yes
UseDNS no
X11Forwarding yes
UsePrivilegeSeparation sandbox      # Default for new installations.
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
Subsystem   sftp    /usr/libexec/openssh/sftp-server
PermitRootLogin no
"
NTP_SERVER1=11.176.1.22
NTP_SERVER2=11.176.1.26
NTP_CONF="driftfile /var/lib/ntp/drift
restrict default nomodify notrap nopeer noquery
restrict 127.0.0.1 
restrict ::1
server $NTP_SERVER1 iburst
server $NTP_SERVER2 iburst
includefile /etc/ntp/crypto/pw
keys /etc/ntp/keys
disable monitor"
NTP_FILE=/etc/ntp.conf
ZABBIX_VERSION=2.4.6
ZABBIX_URL=http://18.18.96.10/easy_init/zabbix-$ZABBIX_VERSION.tar.gz
ZABBIX_LOCAL=/usr/local/zabbix
ZABBIX_AGENT_CONFIG_FILE=$ZABBIX_LOCAL/etc/zabbix_agent.conf
ZABBIX_AGENTD_CONFIG_FILE=$ZABBIX_LOCAL/etc/zabbix_agentd.conf
ZABBIX_SERVER_IP=18.18.96.10
ZABBIX_AGENT_CONFIG="Server=$ZABBIX_SERVER_IP"

RC_LOCAL_FILE=/etc/rc.d/rc.local
RC_LOCAL="#!/bin/bash

touch /var/lock/subsys/local
# CLose the enforce
setenforce 0
iptables -F
iptables -A INPUT -p tcp --dport 22 -m iprange ! --src-range 18.18.96.1-18.18.103.255 -j DROP
iptables -A INPUT -p tcp --dport 3306 -m iprange ! --src-range 18.18.96.1-18.18.96.255 -j DROP

# Start the Zabbix
cd $ZABBIX_LOCAL/sbin/
./zabbix_agentd
"

echo "=================================================="
echo -e "Welcome to use \033[32measy_init\033[0m script!"
echo

if [ -r /etc/redhat-release ]; then
    OS_SYSTEM=`cat /etc/redhat-release`
    OS_SYSTEM_VERSION=`awk '{print $(NF-1)}' /etc/redhat-release`
    echo -e "System: \033[32m$OS_SYSTEM\033[0m"
else
    echo -e "\033[31mNot supported yet. Exit!\033[0m"
    exit 1
fi
echo

# Change to root
echo "#1. Change to root"
if [ `id -u` -ne 0 ];then
    echo -e "\033[31mYou should run it as root.\033[0m"
    exit 1
fi
echo -e "Root: \033[32mOK\033[0m"
echo

# Change hostname
echo "#2. Change hostname:"
read -p "Please enter hostname(e.g hzzhd-03-CentOS7.hzzhd): " HOSTNAME
echo -e "Hostname: \033[32m$HOSTNAME\033[0m"
echo "$HOSTNAME" > $HOSTNAME_FILE
hostname -F $HOSTNAME_FILE
echo

# Change DNS server
echo "#3. Change DNS server:"
echo -e "Search domain: \033[32m$SEARCH\033[0m"
echo -e "Dns server1: \033[32m$DNSSERVER1\033[0m"
echo -e "Dns server2: \033[32m$DNSSERVER2\033[0m"
echo "search $SEARCH
nameserver $DNSSERVER1
nameserver $DNSSERVER2
" > $DNSSERVER_FILE
echo 

# Add SA user
add_user() {
    egrep "^$1" /etc/passwd >& /dev/null
    if [ $? -ne 0 ];then
        adduser $1
    fi
}

echo "#4. Add SA account:"
add_user $SA_USER1
add_user $SA_USER2
echo -e "Add SA account \033[32m$SA_USER1 $SA_USER2\033[0m Done!"
echo

# Change sshd config file
add_public_key() {
    USER_SSH_DIR=/home/$1/.ssh
    if [ ! -d $USER_SSH_DIR ];then
        mkdir $USER_SSH_DIR 
    fi
    echo $2 > $USER_SSH_DIR/authorized_keys
    chown -R $1:$1 $USER_SSH_DIR 
    chmod 700 $USER_SSH_DIR/authorized_keys 
}

echo "#5. Change sshd config file and public key:"
add_public_key $SA_USER1 "$SA_USER1_PUBLIC_KEY"
add_public_key $SA_USER2 "$SA_USER2_PUBLIC_KEY"

mv -f $SSHD_CONFIG_FILE $SSHD_CONFIG_FILE.bak
echo "$SSHD_CONFIG" > $SSHD_CONFIG_FILE
echo -e "Change sshd config file and public key Done!"
echo

# Configure yum source
echo "#6. Configure yum source:"

find /etc/yum.repos.d/ -type f |xargs -i mv -f {} {}.bak
# for file in 'ls /etc/yum.repos.d/'; 
# do 
#     mv -f /etc/yum.repos.d/${file} /etc/yum.repos.d/${file}.bak;
# done
case "$OS_SYSTEM_VERSION" in 
    6.*)
        echo "$CENTOS6_YUM" > $YUM_FILE
        ;;
    7.*)
        echo "$CENTOS7_YUM" > $YUM_FILE
        ;;
    *)
        exit 1
esac
yum upgrade
yum update
echo
echo -e "Configure yum source Done!"
echo

# Install basic software
echo "#5. Install basic software:"
yum install -y vim gcc net-tools libdb-devel openssl openssl-devel git lrzsz wget ntp tree telnet strace tcpdump sysstat pciutils
echo
case "$OS_SYSTEM_VERSION" in 
    6.*)
        service ntpd start
        ;;
    7.*)
        systemctl enable ntpd
        systemctl start ntpd
        ;;
    *)
        exit 1
esac
echo -e "Install basic software Done!"
echo

# Config vimrc enviorment
echo "#7. Config root vimrc"
echo "$VIMRC_CONFIG" > $ROOT_VIMRC_FILE
echo -e "Config root vimrc Done!"
echo

# Install zabbix agent
echo "#8. Install zabbix agent"
groupadd zabbix
useradd -g zabbix zabbix
wget $ZABBIX_URL
tar -zxvf ./zabbix-$ZABBIX_VERSION.tar.gz
cd zabbix-$ZABBIX_VERSION
./configure --enable-agent --prefix=$ZABBIX_LOCAL
make install
echo "$ZABBIX_AGENT_CONFIG" > $ZABBIX_AGENT_CONFIG_FILE
echo "LogFile=/tmp/zabbix_agentd.log
Server=$ZABBIX_SERVER_IP
ServerActive=$ZABBIX_SERVER_IP
Hostname=$HOSTNAME" > $ZABBIX_AGENTD_CONFIG_FILE

$ZABBIX_LOCAL/sbin/zabbix_agentd
echo -e "Zabbix server: \033[32m$ZABBIX_SERVER_IP\033[0m"
echo -e "Zabbix local: \033[32m$ZABBIX_LOCAL\033[0m"
echo -e "Install zabbix agent Done!"
echo


# Config startup script and ntp
echo "#9. Config startup script and ntp"
chmod +x $RC_LOCAL_FILE
echo "$RC_LOCAL" > $RC_LOCAL_FILE
echo "$NTP_CONF" > $NTP_FILE
echo -e "Ntp server1: \033[32m$NTP_SERVER1\033[0m"
echo -e "Ntp server2: \033[32m$NTP_SERVER2\033[0m"
echo -e "Config startup script and ntp Done!"
echo

# Restart service
case "$OS_SYSTEM_VERSION" in 
    6.*)
        service sshd restart
        service ntpd restart
        ;;
    7.*)
        systemctl restart sshd
        systemctl restart ntpd
        ;;
    *)
        exit 1
esac
setenforce 0
iptables -F

echo "=============================================="
echo -e "\033[32mInital system successfully!\033[0m!"
