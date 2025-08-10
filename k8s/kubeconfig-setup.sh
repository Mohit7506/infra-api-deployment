#!/bin/bash
set -e

# === CONFIGURATION ===
SSH_KEY="$HOME/.ssh/id_rsa_imago"
MASTER_USER="ubuntu"
MASTER_PUBLIC_IP=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=imago-server-a" \
  --query "Reservations[].Instances[].PublicIpAddress" \
  --region "us-east-1" \
  --output text)

# If AWS CLI isn't an option, set MASTER_PUBLIC_IP manually:
# MASTER_PUBLIC_IP="X.X.X.X"

if [[ -z "$MASTER_PUBLIC_IP" ]]; then
  echo "[ERROR] Could not detect master public IP"
  exit 1
fi

echo "[INFO] Detected Master Public IP: $MASTER_PUBLIC_IP"

# === COPY K3S CONFIG ===
scp -i "$SSH_KEY" \
    "$MASTER_USER@$MASTER_PUBLIC_IP:/etc/rancher/k3s/k3s.yaml" \
    ./k3s-kubeconfig

# === MODIFY CONFIG ===
sed -i "s/127\.0\.0\.1/$MASTER_PUBLIC_IP/g" k3s-kubeconfig
sed -i '/certificate-authority-data:/ s/^/  # /' k3s-kubeconfig

# Insert insecure-skip-tls-verify under 'server:'
awk '/server:/{print; print "    insecure-skip-tls-verify: true"; next}1' k3s-kubeconfig > tmpfile && mv tmpfile k3s-kubeconfig

# === EXPORT CONFIG ===
export KUBECONFIG=$(pwd)/k3s-kubeconfig

echo "[INFO] KUBECONFIG set to $(pwd)/k3s-kubeconfig"
echo "[INFO] You can now run: kubectl get nodes"

