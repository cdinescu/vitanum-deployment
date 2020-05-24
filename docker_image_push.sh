#!/bin/bash

echo "1) Build jar classes"

./gradlew bootJar

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

IMG_TAG=$RELEASE
IMAGE_NAME=$DOCKER_USERNAME/$DOCKER_REPO:$IMG_TAG

echo "2) Build Docker image"
docker build -t "$IMAGE_NAME" .

echo "3) Push Docker image"
docker push "$IMAGE_NAME"

