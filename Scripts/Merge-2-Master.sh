#!/bin/bash
### Configuration Settings
# Today's date
todays_date=$(date '+%Y-%m-%d')
# Git default branch i.e. master or main
default_branch=main
display=CONSOLE

### Prompt User for Functionality
# Verifiying branch name
{
        read -p "$display: Is the deployment branch ITD-$todays_date? (Y/N) " date_user_question;
        if [ $date_user_question = Y ] || [ $date_user_question = y ];
        then
                deployment_name=ITD-$todays_date
        else
                read -p "$display: Please enter branch's name: ITD-" deployment_date_temp;
                deployment_name=ITD-$deployment_date_temp
        fi
}
# Asks which user for what repo they want to work in
{
        echo -n "$display: What repo are you working in? ";
        read;
        working_repo=${REPLY};
        echo -n ""
}
echo ""
echo ""
# Changes directory into repo
echo -n "$display: Changing directories to $working_repo"
echo ""
cd ./Repositories/$working_repo
# Checks out master
echo -n "$display: Checking out main branch"
echo ""
git checkout $default_branch
echo -n "$display: Pulling updates from $default_branch branch"
echo ""
git pull
echo -n "$display: Merging $deployment_name into $default_branch branch"
echo ""
git merge origin/$deployment_name
echo -n "$display: Pushing release into repo"
echo""
git push
# Changes directory back to initial
echo -n "$display: Changing back to initial directory"
echo ""
cd ../../
