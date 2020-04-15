#!/bin/bash

BASE_URL='http://127.0.0.1:8082/api/diaryEntries'

log() {
  echo -e "\n======================================================\n"
}

getDiaryEntry() {
  diary_date=$1
  URL="${BASE_URL}/search/findByDate?date=${diary_date}"

  HTTP_STATUS=$(curl -w "%{http_code}" \
                     --silent --output /dev/null \
                     -X GET "${URL}")

  echo "${HTTP_STATUS}"
}

insertDiaryEntry() {
  diary_date=$1
  URL="${BASE_URL}"

  request_body='
    {
    "description": "Tomato",
    "amount": 100,
    "unit": "g",
    "calories" : "50",
    "date": "'${diary_date}'"
    }'

  HTTP_RESPONSE=$(curl -silent --write-out "HTTPSTATUS:%{http_code}" \
                       -H "Content-Type: application/json" \
                       -X POST --data "${request_body}" "${URL}")

  echo "${HTTP_RESPONSE}"
}

deleteDiaryEntry() {
  diary_entry_id=$1
  URL="${BASE_URL}/${diary_entry_id}"

  HTTP_STATUS=$(curl -w "%{http_code}" \
                     --silent --output /dev/null \
                     -X DELETE --data "${request_body}" "${URL}")

  echo "${HTTP_STATUS}"
}

check_status() {
  HTTP_STATUS=$1
  EXPECTED_STATUS=$2

  if [[ ! "$HTTP_STATUS" -eq "${EXPECTED_STATUS}"  ]]; then
    echo "[test_GetDiaryEntries] Failed: [HTTP status: $HTTP_STATUS]"
    exit 1
  else
    echo "[test_GetDiaryEntries] Success: HTTP_STATUS is "${EXPECTED_STATUS}""
  fi
}

test_GetDiaryEntries() {
  log

  # Insert test data
  diary_date="2020-04-15"
  HTTP_RESPONSE=$(insertDiaryEntry ${diary_date})
  DIARY_ID=$(echo "${HTTP_RESPONSE}" | grep --col id |  tr -d " \t\n\r," | awk -F ':' '{print $2}')
  HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')

  # extract the status
  HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')
  check_status "${HTTP_STATUS}" "201"

  # Get diary entry
  HTTP_STATUS=$(getDiaryEntry ${diary_date})
  check_status "${HTTP_STATUS}" "200"

  # Clean up
  HTTP_STATUS=$(deleteDiaryEntry ${DIARY_ID})

  echo "Delete status: ${HTTP_STATUS}: ID => ${DIARY_ID}"
  check_status "${HTTP_STATUS}" "204"
}

# Run the tests
test_GetDiaryEntries
