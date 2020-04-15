#!/bin/bash

SEARCH_URL='http://127.0.0.1:8082/foods/search?foodSearchKeyword='
REPORTS_URL='http://127.0.0.1:8082/foods/reports/'

log() {
  echo -e "\n======================================================\n"
}

test_FoodFound() {
  log

  SEARCH_TOKEN='tomato'
  URL="${SEARCH_URL}${SEARCH_TOKEN}"
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
    echo "[test_FoodFound] Failed: HTTP body is empty"
    exit 1
  else
    echo -e "[test_FoodFound] Success: HTTP body is not empty:\n"
    echo ${HTTP_BODY} | jq
  fi
}

test_FoodNotFound() {
  log

  ITEM_NOT_FOUND="randomestrandomthing"
  URL="${SEARCH_URL}${ITEM_NOT_FOUND}"
  HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X GET $URL)

  # extract the body
  HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

  # extract the status
  HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

  # example using the status
  if [ ! $HTTP_STATUS -eq 404  ]; then
    echo "[test_FoodNotFound] Failed: [HTTP status: $HTTP_STATUS]"
    exit 1
  else
    echo "[test_FoodNotFound] Success: HTTP_STATUS is 404"
  fi
}

test_FoodReport_ValidFoodId() {
  log

  FOOD_ID="783051"
  URL="${REPORTS_URL}${FOOD_ID}"
  HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X GET $URL)

  # extract the body
  HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

  # extract the status
  HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')


  # example using the status
  if [ ! $HTTP_STATUS -eq 200  ]; then
    echo "[test_FoodReport_ValidFoodId] Failed: [HTTP status: $HTTP_STATUS]"
    exit 1
  else
    echo "[test_FoodReport_ValidFoodId] Success: HTTP_STATUS is 200"
  fi

  if [[ -z "$HTTP_BODY" ]]
  then
    echo "[test_FoodReport_ValidFoodId] Failed: HTTP body is empty"
    exit 1
  else
    echo -e "[test_FoodReport_ValidFoodId] Success: HTTP body is not empty:\n"
    echo ${HTTP_BODY} | jq
  fi
}

test_FoodReport_InvalidFoodId() {
  log

  FOOD_ID="bla"
  URL="${REPORTS_URL}${FOOD_ID}"

  HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}" -X GET $URL)

  # extract the body
  HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

  # extract the status
  HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

  # example using the status
  if [ ! $HTTP_STATUS -eq 404  ]; then
    echo "[test_FoodReport_InvalidFoodId] Failed: [HTTP status: $HTTP_STATUS]"
    exit 1
  else
    echo "[test_FoodReport_InvalidFoodId] Success: HTTP_STATUS is 404"
  fi
}


# Run the tests
test_FoodFound
test_FoodNotFound
test_FoodReport_ValidFoodId
test_FoodReport_InvalidFoodId
