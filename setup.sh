# refresh d
apt update
# apt upgrade -y
# NEEDRESTART_MODE=a apt-get dist-upgrade --yes
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
apt autoremove -y && apt clean -y

# install necessary tools
DEBIAN_FRONTEND=noninteractive apt install -y git curl wget vim neofetch


# get 
echo "Network interface: $(ls /sys/class/net | grep en)"
