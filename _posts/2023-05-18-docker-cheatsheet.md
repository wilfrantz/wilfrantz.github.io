---
title: Docker Cheat Sheet Tutorial
date: 2023-05-18 11:33:00 +0800
categories: [Blogging, Tutorial]
tags: [docker]
pin: false 
math: true
mermaid: true
image: 
---

### **Basic Commands**

- **Check Docker Version**

  ```bash
  docker --version
  ```

- **Get Docker Info**

  ```bash
  docker info
  ```

- **List Docker Images**

  ```bash
  docker images
  ```

- **List Docker Containers**

  ```bash
  docker ps          # Running containers
  docker ps -a       # All containers, including stopped ones
  ```

- **Run a Docker Container**

  ```bash
  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
  ```

- **Start a Docker Container**

  ```bash
  docker start CONTAINER_ID
  ```

- **Stop a Docker Container**

  ```bash
  docker stop CONTAINER_ID
  ```

- **Remove a Docker Container**

  ```bash
  docker rm CONTAINER_ID
  ```

- **Remove a Docker Image**

  ```bash
  docker rmi IMAGE_ID
  ```

### **Building and Managing Images**

- **Build a Docker Image**

  ```bash
  docker build -t IMAGE_NAME:TAG .
  ```

- **Tag a Docker Image**

  ```bash
  docker tag IMAGE_ID REPOSITORY:TAG
  ```

- **Push an Image to a Repository**

  ```bash
  docker push REPOSITORY:TAG
  ```

- **Pull an Image from a Repository**

  ```bash
  docker pull REPOSITORY:TAG
  ```

- **View Dockerfile History**

  ```bash
  docker history IMAGE_NAME
  ```

### **Container Operations**

- **Execute a Command in a Running Container**

  ```bash
  docker exec [OPTIONS] CONTAINER_ID COMMAND [ARG...]
  ```

- **Get Interactive Shell in a Container**

  ```bash
  docker exec -it CONTAINER_ID /bin/bash
  ```

- **View Container Logs**

  ```bash
  docker logs CONTAINER_ID
  ```

- **Check Container Resource Usage**

  ```bash
  docker stats
  ```

- **Inspect Container Details**

  ```bash
  docker inspect CONTAINER_ID
  ```

### **Networking**

- **List Docker Networks**

  ```bash
  docker network ls
  ```

- **Create a New Docker Network**

  ```bash
  docker network create NETWORK_NAME
  ```

- **Connect a Container to a Network**

  ```bash
  docker network connect NETWORK_NAME CONTAINER_ID
  ```

- **Disconnect a Container from a Network**

  ```bash
  docker network disconnect NETWORK_NAME CONTAINER_ID
  ```

- **Inspect a Network**

  ```bash
  docker network inspect NETWORK_NAME
  ```

### **Volumes**

- **List Docker Volumes**

  ```bash
  docker volume ls
  ```

- **Create a Docker Volume**

  ```bash
  docker volume create VOLUME_NAME
  ```

- **Inspect a Volume**

  ```bash
  docker volume inspect VOLUME_NAME
  ```

- **Remove a Docker Volume**

  ```bash
  docker volume rm VOLUME_NAME
  ```

### **Docker Compose**

- **Install Docker Compose**

  ```bash
  # Follow official installation instructions: https://docs.docker.com/compose/install/
  ```

- **Start Services Defined in docker-compose.yml**

  ```bash
  docker-compose up
  ```

- **Start Services in Detached Mode**

  ```bash
  docker-compose up -d
  ```

- **Stop Services**

  ```bash
  docker-compose down
  ```

- **View Logs for Services**

  ```bash
  docker-compose logs
  ```

- **Execute Command in a Service Container**

  ```bash
  docker-compose exec SERVICE_NAME COMMAND
  ```

- **List All Docker Compose Services**

  ```bash
  docker-compose ps
  ```

### **Advanced Commands**

- **Build and Run Docker Image in One Command**

  ```bash
  docker build -t IMAGE_NAME:TAG . && docker run IMAGE_NAME:TAG
  ```

- **Save a Docker Image to a Tar File**

  ```bash
  docker save -o IMAGE_NAME.tar IMAGE_NAME:TAG
  ```

- **Load a Docker Image from a Tar File**

  ```bash
  docker load -i IMAGE_NAME.tar
  ```

- **Export a Docker Container to a Tar File**

  ```bash
  docker export CONTAINER_ID -o CONTAINER_NAME.tar
  ```

- **Import a Docker Container from a Tar File**

  ```bash
  docker import CONTAINER_NAME.tar
  ```

- **Remove All Stopped Containers**

  ```bash
  docker container prune
  ```

- **Remove All Unused Images**

  ```bash
  docker image prune -a
  ```

- **Remove All Unused Volumes**

  ```bash
  docker volume prune
  ```

- **Remove All Unused Networks**

  ```bash
  docker network prune
  ```

### **Helpful Tips**

- **View Docker Command Help**

  ```bash
  docker COMMAND --help
  ```

- **View Docker Compose Command Help**

  ```bash
  docker-compose COMMAND --help
  ```

This cheatsheet should cover most of the essential Docker commands and operations you'll need for everyday tasks and advanced use cases.
