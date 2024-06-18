#!/bin/bash

# Variables
DOCKER_HUB_IMAGE="ubuntu:latest"
PRIVATE_REGISTRY_IMAGE="your-registry/ubuntu:latest"
TEMP_IMAGE_NAME="temp-ubuntu-image"

# Pull the latest image from Docker Hub
docker pull $DOCKER_HUB_IMAGE

# Calculate hash of the latest image from Docker Hub
HUB_IMAGE_HASH=$(docker inspect --format='{{index .Id}}' $DOCKER_HUB_IMAGE)

# Pull the image from your private registry
docker pull $PRIVATE_REGISTRY_IMAGE

# Calculate hash of the image from your private registry
PRIVATE_REGISTRY_IMAGE_HASH=$(docker inspect --format='{{index .Id}}' $PRIVATE_REGISTRY_IMAGE)

# Compare the hashes
if [ "$HUB_IMAGE_HASH" == "$PRIVATE_REGISTRY_IMAGE_HASH" ]; then
    echo "The images match."
else
    echo "The images do not match."
fi

# Cleanup
docker rmi $DOCKER_HUB_IMAGE $PRIVATE_REGISTRY_IMAGE $TEMP_IMAGE_NAME
