# Use an official Ubuntu base image
FROM ubuntu:latest

# Update the package list and install stress
RUN apt-get update && apt-get install -y stress

# Copy the stress-loop script into the container
COPY stress-loop.sh /usr/local/bin/stress-loop.sh

# Make the script executable
RUN chmod +x /usr/local/bin/stress-loop.sh

# Set the entrypoint to the stress-loop script
ENTRYPOINT ["sh", "/usr/local/bin/stress-loop.sh"]
