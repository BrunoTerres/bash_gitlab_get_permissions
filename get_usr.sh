#! /bin/bash

echo "ID,Username,Email,State,Admin, last activity on" > user_activity2.csv
curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/users?per_page=100 | jq '.[]' | jq "select ((.web_url | contains(\"bot\") | not))" | jq '"\(.id) \(.username) \(.email) \(.state) \(.is_admin) \(.last_activity_on)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g' >> user_activity2.csv


