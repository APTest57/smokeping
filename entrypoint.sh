#!/bin/sh

BUCKET_NAME="smokeping-rrd-data"

# Configuration à la volée de rclone pour Cellar S3
mkdir -p ~/.config/rclone
cat <<EOF > ~/.config/rclone/rclone.conf
[cellar]
type = s3
provider = Ceph
endpoint = https://${CELLAR_ADDON_HOST}
access_key_id = ${CELLAR_ADDON_KEY_ID}
secret_access_key = ${CELLAR_ADDON_KEY_SECRET}
EOF

# 1. Créer le bucket s'il n'existe pas
rclone mkdir cellar:${BUCKET_NAME}

# 2. Restaurer les fichiers RRD depuis Cellar au démarrage
echo "Restauration des fichiers RRD depuis Cellar..."
rclone sync cellar:${BUCKET_NAME} /data

# 3. Lancer une tâche de synchronisation périodique en arrière-plan (toutes les 15 min)
(
  while true; do
    sleep 900
    echo "Sauvegarde des fichiers RRD vers Cellar..."
    rclone sync /data cellar:${BUCKET_NAME}
  done
) &

# 4. Lancer le processus conteneur d'origine (ex: s6-overlay / init)
exec /init
