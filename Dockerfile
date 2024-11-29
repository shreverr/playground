# Use Docker CLI base image
FROM docker:dind

# Install dependencies for Kestra
RUN apk add --no-cache \
    openjdk21 \
    bash \
    curl \
    unzip

# Download and install Kestra
RUN curl -L "https://api.kestra.io/v1/versions/download" -o kestra.zip && \
    mkdir -p /kestra && \
    unzip kestra.zip -d /kestra && \
    rm kestra.zip && \
    mv /kestra/* /kestra/kestra && \
    chmod +x /kestra/kestra

# Set the working directory to Kestra
WORKDIR /kestra

# Expose the default port Kestra uses
EXPOSE 8080

# Command to start Kestra
CMD ["/kestra/kestra", "server", "local"]
