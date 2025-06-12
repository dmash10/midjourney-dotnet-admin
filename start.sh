#!/bin/bash

# Replace environment variables in config files
if [ ! -z "$DISCORD_USER_TOKEN" ]; then
    sed -i "s/\${DISCORD_USER_TOKEN}/$DISCORD_USER_TOKEN/g" appsettings.Production.json
fi

if [ ! -z "$PORT" ]; then
    sed -i "s/\${PORT:-8080}/$PORT/g" appsettings.Production.json
else
    sed -i "s/\${PORT:-8080}/8080/g" appsettings.Production.json
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Start the application
exec ./Midjourney.API.exe 