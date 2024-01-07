# refresh apt cache and install upgrades
apt update
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
apt autoremove -y && apt clean -y

# install necessary tools
DEBIAN_FRONTEND=noninteractive apt install -y git curl wget vim neofetch tree net-tools

# get the network interface
export network_interface=$(ls /sys/class/net | grep en)
export private_ip=$(ip -f inet addr show $network_interface | awk '/inet / {print $2}' | awk -F '/' '{print $1}')
export master_1_private_ip=$(ip -f inet addr show $network_interface | awk '/inet / {print $2}' | awk -F '/' '{print $1}' | awk -F. '{OFS="."; $4="101"; print}')
echo "Network interface: $network_interface"
echo "Private IP: $private_ip"

# reset the hostname
# sudo hostnamectl set-hostname ${var.instance_name}

# install docker (and remove sudo requirement)
curl -fsSL https://test.docker.com | bash
sudo usermod -aG docker $USER

# install K3S Master
export server_name=$(hostname)

if [[ $(hostname) == master1* ]]
then
    echo "Inital Master"
    
    # install k3s
    # curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644 --node-ip 10.0.10.101 --node-external-ip 10.0.10.101 --flannel-iface enX0 --token QnJpbmdpbmcgaW5kdXN0cmlhbCBzYWZldHkgYW5kIGF1dG9tYXRpb24gdG8gdGhlIGVkZ2Uu" sh -
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644 --node-ip $private_ip --node-external-ip $private_ip --flannel-iface $network_interface --token QnJpbmdpbmcgaW5kdXN0cmlhbCBzYWZldHkgYW5kIGF1dG9tYXRpb24gdG8gdGhlIGVkZ2Uu" sh -
    mkdir ~/.kube
    cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

    # install helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    helm repo add prometheus-repo https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install monitoring prometheus-repo/kube-prometheus-stack

    # install argocd
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
    sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
    rm argocd-linux-amd64

elif [[ $(hostname) == master* ]]
then
    echo "Additional Master"
else
    echo "Worker"
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://$master_1_private_ip:6443 --token QnJpbmdpbmcgaW5kdXN0cmlhbCBzYWZldHkgYW5kIGF1dG9tYXRpb24gdG8gdGhlIGVkZ2Uu --node-ip $private_ip --node-external-ip $private_ip --flannel-iface $network_interface" sh -
fi


