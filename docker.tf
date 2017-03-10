# Configure the Docker provider
provider "docker" {
    host = "tcp://127.0.0.1:2375/"
}

# Create stack container
resource "docker_container" "stack" {
    image = "${docker_image.stack_image.latest}"
    name = "stack"
    depends_on = ["docker_container.redis"]
    links = ["some-redis:redis"]
    ports {
       "internal" = "80"
       "external" = "80"
    }
}

resource "docker_image" "stack_image" {
    name = "manikantanr/stack:latest"
}


# Create redis container
resource "docker_container" "redis" {
    image = "${docker_image.redis_image.latest}"
    name = "some-redis"
}

resource "docker_image" "redis_image" {
    name = "redis:latest"
}