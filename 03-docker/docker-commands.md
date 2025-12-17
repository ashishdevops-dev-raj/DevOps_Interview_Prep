# Docker Commands Cheat Sheet

## Container Management

### Basic Container Operations
```bash
docker run <image>                  # Run container
docker run -d <image>               # Run in detached mode
docker run -it <image> /bin/bash    # Run interactively
docker run -p 8080:80 <image>       # Map port host:container
docker run -v /host:/container <image>  # Mount volume
docker run --name <name> <image>    # Name container
docker run --rm <image>             # Auto-remove after stop
docker run -e VAR=value <image>     # Set environment variable

docker ps                           # List running containers
docker ps -a                        # List all containers
docker ps -q                        # List only container IDs

docker start <container>            # Start stopped container
docker stop <container>             # Stop running container
docker restart <container>          # Restart container
docker pause <container>            # Pause container
docker unpause <container>          # Unpause container

docker rm <container>               # Remove container
docker rm -f <container>            # Force remove running container
docker rm $(docker ps -aq)          # Remove all containers

docker exec -it <container> /bin/bash  # Execute command in running container
docker exec <container> <command>   # Execute command
docker attach <container>           # Attach to container
```

## Image Management

### Image Operations
```bash
docker images                       # List images
docker images -a                    # List all images (including intermediate)
docker rmi <image>                  # Remove image
docker rmi -f <image>               # Force remove image
docker pull <image>                 # Pull image from registry
docker push <image>                 # Push image to registry
docker tag <image> <new-tag>        # Tag image
docker build -t <tag> .             # Build image from Dockerfile
docker build -f <dockerfile> .      # Build with specific Dockerfile
docker history <image>              # Show image history
docker inspect <image>              # Inspect image details
```

## Dockerfile

### Common Instructions
```dockerfile
FROM <image>                        # Base image
WORKDIR /path                       # Set working directory
COPY <src> <dest>                   # Copy files
ADD <src> <dest>                    # Copy files (supports URLs, tar)
RUN <command>                       # Execute command during build
CMD ["executable", "param"]         # Default command
ENTRYPOINT ["executable"]           # Entry point
ENV KEY=value                       # Environment variable
ARG KEY=value                       # Build-time variable
EXPOSE <port>                       # Expose port
VOLUME ["/path"]                    # Create mount point
USER <user>                         # Set user
LABEL key=value                     # Add metadata
HEALTHCHECK CMD <command>           # Health check
```

## Volumes

```bash
docker volume create <name>         # Create volume
docker volume ls                    # List volumes
docker volume inspect <name>        # Inspect volume
docker volume rm <name>             # Remove volume
docker volume prune                 # Remove unused volumes

# Mount volumes
docker run -v <host-path>:<container-path> <image>
docker run -v <volume-name>:<container-path> <image>
docker run --mount type=bind,source=<host>,target=<container> <image>
docker run --mount type=volume,source=<volume>,target=<container> <image>
```

## Networks

```bash
docker network ls                   # List networks
docker network create <name>        # Create network
docker network inspect <name>       # Inspect network
docker network rm <name>           # Remove network
docker network prune               # Remove unused networks

docker run --network <network> <image>  # Connect to network
docker network connect <network> <container>  # Connect container to network
docker network disconnect <network> <container>  # Disconnect
```

## Logs and Monitoring

```bash
docker logs <container>             # View container logs
docker logs -f <container>          # Follow logs
docker logs --tail 100 <container>  # Last 100 lines
docker logs --since 1h <container>  # Logs since 1 hour

docker stats                        # Real-time container stats
docker stats <container>            # Stats for specific container
docker top <container>              # Running processes in container
docker events                       # Real-time events
```

## System Information

```bash
docker info                         # System-wide information
docker version                      # Docker version
docker system df                    # Disk usage
docker system prune                 # Remove unused data
docker system prune -a              # Remove all unused data (including images)
docker inspect <container>         # Container details
docker inspect <image>             # Image details
```

## Docker Compose

```bash
docker-compose up                   # Start services
docker-compose up -d                # Start in detached mode
docker-compose down                 # Stop and remove containers
docker-compose ps                   # List services
docker-compose logs                 # View logs
docker-compose logs -f <service>    # Follow logs for service
docker-compose build                # Build images
docker-compose build --no-cache     # Build without cache
docker-compose exec <service> <cmd> # Execute command in service
docker-compose restart <service>    # Restart service
docker-compose stop                 # Stop services
docker-compose start                # Start services
docker-compose pull                 # Pull images
docker-compose config               # Validate and view config
docker-compose scale <service>=<n>  # Scale service
```

## Advanced Commands

### Multi-stage Builds
```bash
docker build --target <stage> -t <tag> .  # Build specific stage
```

### Save and Load
```bash
docker save <image> -o file.tar     # Save image to tar
docker load -i file.tar             # Load image from tar
docker export <container> -o file.tar  # Export container
docker import file.tar <image>     # Import as image
```

### Prune Commands
```bash
docker container prune              # Remove stopped containers
docker image prune                  # Remove unused images
docker image prune -a               # Remove all unused images
docker volume prune                 # Remove unused volumes
docker network prune                # Remove unused networks
docker system prune                 # Remove all unused resources
```

## Best Practices

### Security
```bash
docker run --read-only <image>     # Read-only root filesystem
docker run --user <uid> <image>    # Run as non-root user
docker run --cap-drop ALL <image>  # Drop all capabilities
docker run --security-opt no-new-privileges <image>
```

### Resource Limits
```bash
docker run --memory="512m" <image>  # Limit memory
docker run --cpus="1.5" <image>    # Limit CPU
docker run --memory-swap="1g" <image>  # Limit swap
```

### Health Checks
```bash
docker run --health-cmd="curl -f http://localhost" \
           --health-interval=30s \
           --health-timeout=3s \
           --health-retries=3 <image>
```

## Troubleshooting

```bash
docker logs <container>             # Check logs
docker exec -it <container> sh      # Access container shell
docker inspect <container>         # Inspect configuration
docker diff <container>            # Show filesystem changes
docker commit <container> <image>  # Create image from container
```

