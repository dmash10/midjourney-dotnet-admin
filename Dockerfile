# Use Ubuntu as base since this is a self-contained executable
FROM ubuntu:22.04 AS base
WORKDIR /app

# Install required dependencies for .NET applications
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu70 \
    libssl3 \
    libstdc++6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Copy the application
COPY . .

# Make the executable file executable
RUN chmod +x Midjourney.API.exe

# Set environment variables
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["./Midjourney.API.exe"] 