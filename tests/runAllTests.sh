#!/bin/bash

echo "Waiting for the services to start"

sleep 60
echo "Running food-service tests....."
./test_food_service.sh
