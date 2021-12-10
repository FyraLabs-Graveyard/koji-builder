# Koji Builder

Docker image for deploying `kojid` in non-RPM environments.

# Instructions
- Use the example docker-compose.yml to deploy the builder.

You must have an already working Koji instance running and configured.

You also must have access to the NFS share where the Koji files are mounted, and set them up in your docker-compose.yml.