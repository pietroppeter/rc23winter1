# Use a Nim base image
FROM nimlang/nim:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Nim source code into the container
COPY . /app

# Compile the Nim application
RUN nimble c -d:release server

# Expose the port your Nim server is listening on
EXPOSE 8080

# Set the command to run when the container starts
CMD ["/app/server"]