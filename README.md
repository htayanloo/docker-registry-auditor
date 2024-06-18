# docker-registry-auditor



docker registry auditor is a tool designed to scan and identify Docker images in a private registry that are based on an invalid or compromised base image. This tool helps ensure the integrity and security of your Docker images by comparing their hashes with the original images.

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features
- List all repositories in a private Docker registry.
- List all tags for each repository.
- Inspect Docker images and get their base image hash.
- Compare image hashes to identify images based on an invalid or compromised base image.

## Requirements
- Docker
- Skopeo
- jq (JSON processor)
- curl (Command line tool for transferring data with URLs)

## Installation

### Install Docker
Follow the instructions to install Docker from the official Docker website: [Docker Installation](https://docs.docker.com/get-docker/)

### Install Skopeo
Skopeo is required for inspecting images in the private registry. Install Skopeo using the following instructions:

#### For Linux:
```bash
sudo apt-get install skopeo
