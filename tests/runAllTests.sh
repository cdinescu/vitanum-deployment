#!/bin/bash

echo "Waiting for the services to start"

echo "Running food-service tests....."
./test_food_service.sh

echo "Running ask-oracle-service tests....."
./test_askoracle_service.sh

echo "Running diary-service tests....."
./test_diary_service.sh

echo -e "\n==================================\n"

if [[ ${?} -eq 0 ]]; then
  echo "All tests have run successfully!"
else
  echo "There are test failures!"
fi
