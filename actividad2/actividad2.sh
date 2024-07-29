#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

#variables por defecto
GITHUB_USER="${GITHUB_USER:-erkest}"
API_URL="https://api.github.com/users/$GITHUB_USER"
LOG_DIR="tmp/$(date +%Y-%m-%d_%H-%M-%S)"
LOG_FILE="$LOG_DIR/saludos.log"

#realizar la peticion
#-s : silent mode
result=$(curl -s $API_URL)


if [ $? -eq 0 ]; then
github_user=$(echo "$result" | jq -r '.login')
id=$(echo "$result" | jq -r '.id')
created_at=$(echo "$result" |jq -r '.created_at')

mensaje="Hola $github_user. User ID: $id. Cuenta fue creada el: $created_at."
echo $mensaje

echo $LOG_FILE
#crear carpeta y arhivo
mkdir -p $LOG_DIR
echo $mensaje > $LOG_FILE
else
echo "No se pudo realizar la peticion"
fi



#requisitos para el script:
#tener instalado curl y jq

#------- creacion de un cronjob -------------
#1. usar el comando:
#crontab -e

#2. agregar al archivo lo siguiente:
#*/5 * * * * actividad2.sh

#cada asterisco significa una unidad de tiempo:
#*/5 -> 5 minutos
#el segundo asterisco es hora, luego mes

