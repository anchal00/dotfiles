# Use a base image with Bash
FROM ubuntu:20.04

# Install necessary dependencies (update this as needed)
WORKDIR /app

# Copy your script into the container
COPY ubuntu.sh /app/ubuntu.sh
COPY install.sh /app/install.sh

# Make the script executable
RUN chmod +x /app/ubuntu.sh
RUN chmod +x /app/install.sh

# Default command to run the script
ENTRYPOINT ["bash"]
