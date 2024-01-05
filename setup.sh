# refresh apt cache and install upgrades
apt update
# apt upgrade -y
# NEEDRESTART_MODE=a apt-get dist-upgrade --yes
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
apt autoremove -y && apt clean -y

# install necessary tools
DEBIAN_FRONTEND=noninteractive apt install -y git curl wget vim neofetch tree net-tools

# get the network interface
echo "Network interface: $(ls /sys/class/net | grep en)"

# install docker

# install helm

# install k3s (master/worker)
