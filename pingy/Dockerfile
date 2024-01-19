# Use a Nim base image
FROM nimlang/nim:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Nim source code into the container
COPY . /app

# Compile the Nim application
RUN nimble c -d:release -y server

# Set the command to run when the container starts
CMD ["/app/server"]