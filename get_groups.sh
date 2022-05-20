#! /bin/bash

# echo "ID,Name" > groups.csv
curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups?per_page=100 | jq '.[]' | jq '"\(.id) \(.name)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g' >> groups.csv
GROUP_LIST=$(curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups?per_page=100 | jq '.[]' | jq '"\(.id) \(.name)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g')

for G in ${GROUP_LIST}
do 
  IFS=', ' read -r -a ARRAY <<< "$G"
  echo "ID, Username, State, Access Lvl" > "${ARRAY[1]}.csv"
  curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups/${ARRAY[0]}/members/all | jq '.[]' | jq '"\(.id) \(.username) \(.state) \(.access_level)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g' >> "${ARRAY[1]}.csv"
done