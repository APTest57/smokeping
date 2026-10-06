#!/bin/sh

BUCKET_NAME="smokeping-rdd-data-s3"

echo "=== [Cellar] Syncing RRD files to S3 ==="
rclone sync /data cellar:${BUCKET_NAME}
