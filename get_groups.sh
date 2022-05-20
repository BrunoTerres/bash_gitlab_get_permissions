#! /bin/bash

echo "ID,Name" > groups.csv
curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups?per_page=100 | jq '.[]' | jq '"\(.id) \(.name)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g' >> groups.csv
TEST=$(curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups?per_page=100 | jq '.[]' | jq '"\(.id) \(.name)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g')
 
for T in ${TEST}
do 
  echo ${T}
  #curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups/${T[0]}/members/all
done