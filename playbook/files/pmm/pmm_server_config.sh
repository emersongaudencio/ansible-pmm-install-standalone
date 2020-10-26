#!/bin/bash
echo "HOSTNAME: " `hostname`
echo "BEGIN - [`date +%d/%m/%Y" "%H:%M:%S`]"
echo "##############"

# Starting and Enabling - Docker service
systemctl enable docker.service
systemctl start docker.service

# Pull the latest 2.x image
docker pull percona/pmm-server:2

# Create a persistent data container
docker create --volume /srv --name pmm-data percona/pmm-server:2 /bin/true

# Run the image to start PMM Server
docker run --detach --restart always \
--publish 80:80 --publish 443:443 \
--volumes-from pmm-data --name pmm-server \
percona/pmm-server:2

# List docker status
docker ps --all

echo "##############"
echo "END - [`date +%d/%m/%Y" "%H:%M:%S`]"
