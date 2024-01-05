# refresh d
apt update
# apt upgrade -y
NEEDRESTART_MODE=a apt-get dist-upgrade --yes
apt autoremove -y && apt clean -y

# install necessary tools
apt install -y git curl wget vim neofetch

# get 
echo "Network interface: $(ls /sys/class/net | grep en)"
