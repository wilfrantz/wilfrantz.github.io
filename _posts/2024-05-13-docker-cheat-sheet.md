---
title: My Docker Cheat Sheet
date: 2024-05-13 11:33:00 +0800
toc: true
categories: [cheat Sheet]
---

Docker has revolutionized software development and deployment by providing a streamlined approach to containerization. This cheat sheet enhance my Docker workflow with some advanced commands, best practices, and troubleshooting tips.

## Image Management

* Build an image from a Dockerfile in the current directory.

   ```bash
   docker build -t <image_name>:<tag> .
   ```

* Build without using the cache.
  
  ```bash
  docker build --no-cache -t <image_name>:<tag> .
  ```

* Pass build arguments.
  
  ```bash
  docker build --build-arg <ARG_NAME>=<value> -t <image_name>:<tag> .
  ```
* Build a specific stage in a multi-stage Dockerfile.

  ```bash
  docker build --target <stage> -t <image_name>:<tag> .
  ```

### Listing and Inspecting Images:

* List local images: list all images, including intermediate.

  ```bash
  docker images -a
  ```

* Inspect an image's details.

  ```bash
  docker inspect <image_id|image_name> 
  ```

* Show the history of an image.

    ```bash
    docker history <image_id|image_name>
    ```

### Managing Images:

  * Remove an image.
    ```bash
    docker rmi <image_id|image_name>
    ```
  * Remove dangling images.
    ```bash
    docker rmi $(docker images -aq --filter "dangling=true")
    ```
  * Remove all unused images.
    ```bash
    docker image prune -a
    ```
  * Tagging Images.
    ```bash
    docker tag <image_id|image_name> <new_image_name>:<tag>
    ```

### Pushing and Pulling Images:

  * Log in to a Docker registry.
    
    ```bash
    docker login -u <username> -p <password>
    ```

  * Push an image to a registry.
    
    ```bash
    docker push <image_name>:<tag>
    ```

  * Pull an image from a registry.
    
    ```bash
    docker pull <image_name>:<tag>
    ```

  * Search Docker Hub for an image.
    
    ```bash
    docker search <image_name>
    ```

## Container Management

  * Run a container in detached mode and map ports.
    ```bash
    docker run -d -p <host_port>:<container_port> --name <container_name> <image_name>:<tag>
    ```
  * Run an interactive container and remove it when exited.
    ```bash
    docker run -it --rm <image_name>:<tag> /bin/bash
    ```
  * Run a container with a restart policy.
    ```bash
    docker run --name <container_name> --restart unless-stopped <image_name>:<tag>
    ```
  * Mount a host directory as a volume.
    ```bash
    docker run --mount type=bind,source=<host_path>,target=<container_path> <image_name>:<tag>
    ```
  * Set environment variables.
    ```bash
    docker run --env <VAR>=<value> <image_name>:<tag>
    ```

### Managing Running Containers:

  * List running containers.
    ```bash
    docker ps
    ```

  * List all containers.
    ```bash
    docker ps -a
    ```

  * View container logs.
    ```bash
    docker logs <container_name|container_id>
    ```

  * Follow container logs.
    ```bash
    docker logs -f <container_name|container_id>
    ```

  * Execute a command in a running container.
    ```bash
    docker exec -it <container_name|container_id> /bin/bash
    ```

  * Stop a container.
    ```bash
    docker stop <container_name|container_id>
    ```

  * Start a container.
    ```bash
    docker start <container_name|container_id>
    ```

  * Restart a container.
    ```bash
    docker restart <container_name|container_id>
    ```

  * Remove a stopped container.
    ```bash
    docker rm <container_name|container_id>
    ```

  * Force remove a running container.
    ```bash
    docker rm -f <container_name|container_id>
    ```

  * Rename a container.
    ```bash
    docker rename <container_name> <new_container_name>
    ```

  * Update resource limits.
    ```bash
    docker update --memory=<limit> --cpus=<limit> <container_name|container_id>
    ```

  * Show resource usage statistics.
    ```bash
    docker stats <container_name|container_id>
    ```

### Inspecting Containers:

* Inspect a container's details.
  ```bash
  docker inspect <container_name|container_id>
  ```

* Show file changes in a container's filesystem.
  ```bash
  docker diff <container_name|container_id>
  ```

## Networking

* Listing Networks:
  * List Docker networks.
    ```bash
    docker network ls
    ```

* Creating Networks:
  * Create a Docker network.
    ```bash
    docker network create <network_name>
    ```
  * Create a bridge network.
    ```bash
    docker network create --driver bridge <network_name>
    ```
  * Create an overlay network (for Swarm).
    ```bash
    docker network create --driver overlay <network_name>
    ```

* Connecting Containers to Networks:
  * Connect a container to a network.
    ```bash
    docker network connect <network_name> <container_name|container_id>
    ```
  * Disconnect a container from a network.
    ```bash
    docker network disconnect <network_name> <container_name|container_id>
    ```

* Inspecting Networks:
  * Inspect a Docker network.
    ```bash
    docker network inspect <network_name>
    ```

* Removing Networks:
  * Remove a Docker network.
    ```bash
    docker network rm <network_name>
    ```

## Volume Management

* Listing Volumes:
  * List Docker volumes.
    ```bash
    docker volume ls
    ```

* Creating Volumes:
  * Create a Docker volume.
    ```bash
    docker volume create <volume_name>
    ```

* Inspecting Volumes:
  * Inspect a Docker volume.
    ```bash
    docker volume inspect <volume_name>
    ```

* Removing Volumes:
  * Remove a Docker volume.
    ```bash
    docker volume rm <volume_name>
    ```
  * Remove unused volumes.
    ```bash
    docker volume prune
    ```

## Security

* User Namespaces:
  * Run a container as a specific user.
    ```bash
    docker run --user <user>:<group> <image_name>:<tag>
    ```

* Capabilities:
  * Add or drop Linux capabilities.
    ```bash
    docker run --cap-add <capability> --cap-drop <capability> <image_name>:<tag>
    ```

* Security Profiles:
  * Apply an AppArmor profile.
    ```bash
    docker run --security-opt apparmor=<profile> <image_name>:<tag>
    ```
  * Apply a seccomp profile.
    ```bash
    docker run --security-opt seccomp=<profile.json> <image_name>:<tag>
    ```

* Secrets Management:
  * Create a Docker secret.
    ```bash
    docker secret create <secret_name> <secret_file>
    ```
  * Mount a secret into a container.
    ```bash
    docker run --secret <secret_name> <image_name>:<tag>
    ```

## Troubleshooting

* Container Logs:
  * View container logs.
    ```bash
    docker logs <container_name|container_id>
    ```
  * Follow container logs.
    ```bash
    docker logs -f <container_name|container_id>
    ```

* Inspecting Containers:
  * Inspect container details.
    ```bash
    docker inspect <container_name|container_id>
    ```
  * Show file changes.
    ```bash
    docker diff <container_name|container_id>
    ```

* Network Issues:
  * Inspect network details.
    ```bash
    docker network inspect <network_name>
    ```
  * Ping a host from inside a container.
    ```bash
    docker exec -it <container_name|container_id> ping <host>
    ```
  * Check network connections.
    ```bash
    docker exec -it <container_name|container_id> netstat -tulnp
    ```

* Resource Issues:
  * Monitor resource usage.
    ```bash
    docker stats <container_name|container_id>
    ```
  * Adjust resource limits.
    ```bash
    docker update --memory=<limit> --cpus=<limit> <container_name|container_id>
    ```