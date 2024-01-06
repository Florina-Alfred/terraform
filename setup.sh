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

# reset the hostname
sudo hostnamectl set-hostname ${var.instance_name}

# install docker (and remove sudo requirement)
curl -fsSL https://test.docker.com | bash
sudo usermod -aG docker $USER

# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# install K3S Master
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644 --node-ip 172.31.24.101 --node-external-ip 172.31.24.101 --flannel-iface enX0 --token QnJpbmdpbmcgaW5kdXN0cmlhbCBzYWZldHkgYW5kIGF1dG9tYXRpb24gdG8gdGhlIGVkZ2Uu" sh -
mkdir ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
# install docker

# install helm

# install k3s (master/worker)
