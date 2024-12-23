# Use a base image with Bash
FROM ubuntu:20.04
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive
# Install necessary dependencies (update this as needed)
WORKDIR /home/dotfiles

# Copy everything into the container
COPY . .

# Make the scripts executable
RUN chmod +x kitty-scrollback-setup.sh && chmod +x ubuntu.sh && chmod +x install.sh && chmod +x loadconfigs.sh

# Default command to run the script
ENTRYPOINT ["bash"]
