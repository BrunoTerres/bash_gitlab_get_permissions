#! /bin/bash

# echo "ID,Name" > groups.csv
curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups?per_page=100 | jq '.[]' | jq '"\(.id) \(.name)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g' >> groups.csv
GROUP_LIST=$(curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups?per_page=100 | jq '.[]' | jq '"\(.id) \(.name)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g')

rm "gitlab_usr_permissions.csv"
for G in ${GROUP_LIST}
do 
  IFS=', ' read -r -a ARRAY <<< "$G"
  echo "GROUP ${ARRAY[1]} ${ARRAY[2]} ${ARRAY[3]} ${ARRAY[4]}" >> "gitlab_usr_permissions.csv"
  echo "ID, Username, State, Access Lvl" >> "gitlab_usr_permissions.csv"
  curl -s --header "PRIVATE-TOKEN: $TOKEN" $URL/api/v4/groups/${ARRAY[0]}/members/all | jq '.[]' | jq '"\(.id) \(.username) \(.state) \(.access_level)"' | sed 's/^"\(.*\)"$/\1/' | sed 's/ \{1,\}/,/g' >> "gitlab_usr_permissions.csv"
  echo "" >> "gitlab_usr_permissions.csv"
done

