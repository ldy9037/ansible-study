timedatectl set-timezone Asia/Seoul

if ! dnf list installed epel-release | grep Installed ; then
    dnf install -y epel-release        
fi

if ! dnf list installed ansible | grep Installed ; then
    dnf install -y ansible        
fi

if ! ls -l | grep ansible-study ; then
    git clone https://github.com/ldy9037/ansible-study.git
fi