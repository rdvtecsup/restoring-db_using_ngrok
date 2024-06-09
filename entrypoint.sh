#!/bin/bash
# Entrypoint script to start SQL Server, restore the database, and start ngrok

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
echo "Waiting for SQL Server to start..."
sleep 30s

# Run the database restore script
echo "Restoring database..."
/usr/src/app/restore-database.sh

# Start ngrok to tunnel TCP 1433
echo "Starting ngrok..."
ngrok tcp 1433
