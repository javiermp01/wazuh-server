#!/bin/bash
set -e

# Instala Docker y dependencias si no existen
#sudo apt update && sudo apt install -y curl git
# curl -sSL https://get.docker.com/ | sh

# Clona el repositorio oficial de Wazuh Docker específico de la versión 4.13.1
#cd /opt
#sudo git clone https://github.com/wazuh/wazuh-docker.git -b v4.13.1
#cd wazuh-docker/single-node

# Asegura el valor para el indexer (requerido)
sudo sysctl -w vm.max_map_count=262144

# Genera certificados autofirmados antes de levantar el stack
sudo docker compose -f generate-indexer-certs.yml run --rm generator

# Levanta Wazuh single node con los certificados generados
sudo docker compose up -d

echo "Wazuh 4.13.1 Single Node desplegado. Dashboard en https://<TU-IP>:5601 (usuario: admin, contraseña: revisa los logs)"

