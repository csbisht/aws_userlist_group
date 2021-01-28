#!/bin/bash
script_home=`pwd`
aws iam list-users --query "Users[*].UserName" >${script_home}/aws_userlist.txt

sed -i 's#",##g' ${script_home}/aws_userlist.txt; sed -i 's#"##g' ${script_home}/aws_userlist.txt
sed -i 's/\[//g' ${script_home}/aws_userlist.txt;sed -i 's#]##g' ${script_home}/aws_userlist.txt

for i in `cat ${script_home}/aws_userlist.txt`
do
aws iam list-groups-for-user --user-name $i --query "Groups[*].GroupName" --output table >>${script_home}/list_user_groups.txt
sed -i "s/ListGroupsForUser/${i}/g" ${script_home}/list_user_groups.txt
done

if [ -f ${script_home}/aws_userlist.txt ]; then
rm ${script_home}/aws_userlist.txt
fi
if [ -f ${script_home}/list_user_groups.txt ]; then
echo -e "Your List Groups for Users are here - ${script_home}/list_user_groups.txt \n"
else
echo -e "No User associated with any Groups \n"
fi
