#!/bin/bash

# Variables
REGISTRY_URL="regdock.tayanloo.com"
USERNAME="your-username"
PASSWORD="your-password"
INVALID_UBUNTU_HASH="sha256:your_invalid_image_hash"

# Function to get the list of all repositories
list_repositories() {
  curl -u $USERNAME:$PASSWORD https://$REGISTRY_URL/v2/_catalog | jq -r '.repositories[]'
}

# Function to list tags for a given repository
list_tags() {
  local repo=$1
  curl -u $USERNAME:$PASSWORD https://$REGISTRY_URL/v2/$repo/tags/list | jq -r '.tags[]'
}

# Function to inspect image and get base image hash
get_base_image_hash() {
  local image=$1
  skopeo inspect --creds=$USERNAME:$PASSWORD docker://$REGISTRY_URL/$image | jq -r '.RootFS.Layers[0]'
}

# List all repositories
REPOSITORIES=$(list_repositories)

# Loop through all repositories
for repo in $REPOSITORIES; do
  # List all tags for the repository
  TAGS=$(list_tags $repo)

  for tag in $TAGS; do
    image="$repo:$tag"
    base_image_hash=$(get_base_image_hash $image)
    
    if [ "$base_image_hash" == "$INVALID_UBUNTU_HASH" ]; then
      echo "Image $image is based on the invalid Ubuntu image."
    fi
  done
done
