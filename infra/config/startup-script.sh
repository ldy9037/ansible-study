timedatectl set-timezone Asia/Seoul
dnf update -y

if ! dnf list installed epel-release | grep Installed ; then
    dnf install -y epel-release        
fi

if ! dnf list installed ansible | grep Installed ; then
    dnf install -y ansible        
fi
