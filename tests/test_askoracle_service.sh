#!/bin/bash

REPORTS_URL='http://127.0.0.1:8082/top-richest-foods'

log() {
  echo -e "\n======================================================\n"
}

test_NutrientFound() {
  log

  NUTRIENT_NAME='calcium'
  URL="${REPORTS_URL}/${NUTRIENT_NAME}?maxRecordCount=50"
  HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X GET $URL)

  # extract the body
  HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

  # extract the status
  HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')


  # example using the status
  if [ ! $HTTP_STATUS -eq 200  ]; then
    echo "Failed: [HTTP status: $HTTP_STATUS]"
    exit 1
  else
    echo "Success: HTTP_STATUS is 200"
  fi

  if [[ -z "$HTTP_BODY" ]]
  then
    echo "Failed: HTTP body is empty"
    exit 1
  else
    echo -e "Success: HTTP body is not empty:\n ${HTTP_BODY}"
  fi
}

test_NutrientNotFound() {
  log

  NUTRIENT_NAME='random'
  URL="${REPORTS_URL}/${NUTRIENT_NAME}?maxRecordCount=50"
  HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X GET $URL)

  # extract the body
  HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

  # extract the status
  HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')


  # example using the status
  if [ $HTTP_STATUS -eq 404  ]; then
    echo "Success: HTTP_STATUS is 404"
  else
    echo "Failed: [HTTP status: $HTTP_STATUS]"
    exit 1
  fi
}

# Run the tests
test_NutrientFound
test_NutrientNotFound
