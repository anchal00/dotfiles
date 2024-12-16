# Use a base image with Bash
FROM ubuntu:20.04
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive
# Install necessary dependencies (update this as needed)
WORKDIR /app

# Copy your script into the container
COPY ubuntu.sh install.sh loadconfigs.sh /app/

# Make the scripts executable
RUN chmod +x /app/ubuntu.sh && chmod +x /app/install.sh && chmod +x /app/loadconfigs.sh

# Default command to run the script
ENTRYPOINT ["bash"]
