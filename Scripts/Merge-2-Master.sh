#!/bin/bash
### Configuration Settings
# Today's date
todays_date=$(date '+%Y-%m-%d')
# Git default branch i.e. master or main
default_branch=main
display=$'\e[31mCONSOLE\e[0m:'
# Color variables
PURPLE=$'\e\[35m'
YELLOW=$'\e[33m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
CYAN=$'\e[36m'
NC=$'\e[0m'
BOLD="\033[1m"

### Prompt User for Functionality
# Verifiying branch name
{
        read -p "$display Is the deployment branch$GREEN ITD-$todays_date$NC? (Y/N) $CYAN" date_user_question;
        if [ $date_user_question = Y ] || [ $date_user_question = y ];
        then
                deployment_name=ITD-$todays_date
        else
                read -p "$display Please enter branch's name:$CYAN ITD-" deployment_date_temp;
                deployment_name=ITD-$deployment_date_temp
        fi
}
# Asks which user for what repo they want to work in
{
        echo -n "$display What repo are you working in? $CYAN";
        read;
        working_repo=${REPLY};
        echo -n ""
}
echo ""
# Changes directory into repo
echo -e -n "$display Changing directories to $YELLOW$working_repo$NC"
echo ""
cd ./Repositories/$working_repo
# Checks out master
echo -n "$display Checking out main branch"
echo ""
git checkout $default_branch
echo -e -n "$display Pulling updates from $YELLOW$default_branch$NC branch"
echo ""
git pull
echo -e -n "$display Merging $YELLOW$deployment_name$NC into $YELLOW$default_branch$NC branch"
echo ""
git merge origin/$deployment_name
echo -n "$display Pushing release into repo"
echo""
git push
# Changes directory back to initial
echo -n "$display Changing back to initial directory"
echo ""
cd ../../
