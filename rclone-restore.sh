#!/bin/sh

BUCKET_NAME="smokeping-rrd-data"

echo "=== [Cellar] Initializing S3 Config ==="
mkdir -p /root/.config/rclone

cat <<EOF > /root/.config/rclone/rclone.conf
[cellar]
type = s3
provider = Ceph
endpoint = https://${CELLAR_ADDON_HOST}
access_key_id = ${CELLAR_ADDON_KEY_ID}
secret_access_key = ${CELLAR_ADDON_KEY_SECRET}
acl = private
EOF

# Ensure bucket exists
rclone mkdir cellar:${BUCKET_NAME}

# Restore data from Cellar to SmokePing data directory
echo "=== [Cellar] Restoring RRD files ==="
rclone sync cellar:${BUCKET_NAME} /data
