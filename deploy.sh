#!/bin/bash

# Maven Clean and Verify
echo "Running Maven clean and verify..."
mvn clean verify

# Check if Maven build was successful
if [ $? -ne 0 ]; then
  echo "Maven build failed. Exiting."
  exit 1
fi

# GraalVM Native Image Build
echo "Building GraalVM native image..."
./mvnw spring-boot:build-image

# Check if GraalVM build was successful
if [ $? -ne 0 ]; then
  echo "GraalVM native image build failed. Exiting."
  exit 1
fi

docker login
docker tag stock-service:latest respawnables/stock-service:latest
docker push respawnables/stock-service:latest

# Run Nomad Job
echo "Running Nomad job..."
sudo nomad job run stock-service.nomad.hcl

# Check if Nomad job was successful
if [ $? -ne 0 ]; then
  echo "Nomad job failed. Exiting."
  exit 1
fi

echo "Deployment completed successfully."
