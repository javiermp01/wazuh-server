#!/bin/bash
set -e

echo "[+] Instalando dependencias..."
sudo apt install -y ca-certificates curl gnupg

echo "[+] Configurando clave GPG de Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "[+] Añadiendo repositorio oficial de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[+] Instalando Docker Engine..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "[+] Habilitando y arrancando el servicio docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[+] Instalando Docker Compose v2 (plugin)..."
sudo apt install -y docker-compose-plugin

echo "[+] Comprobando Docker..."
docker --version || sudo docker --version
docker version || true

echo "[+] Comprobando Docker Compose..."
docker compose version || true

echo
echo "[+] Añadiendo al grupo docker (para usar Docker sin sudo)..."
sudo usermod -aG docker "$USER"
echo "[*] IMPORTANTE: cierra sesión y vuelve a entrar para que el grupo 'docker' se aplique."
echo "[+] Instalación completada."

