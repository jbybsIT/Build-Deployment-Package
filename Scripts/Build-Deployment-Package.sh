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
# Naming the deployment branch 
{
#\e[31mFoobar\e[0m
        read -p "$display Is the deployment branch being deployed today, $GREEN$todays_date$NC? (Y/N) $CYAN" date_user_question;
	if [ $date_user_question = Y ] || [ $date_user_question = y ];
	then 
		deployment_name=ITD-$todays_date
	else
		read -p "$display Please enter the date of the branch's deployment:$CYAN ITD-" deployment_date_temp;
		deployment_name=ITD-$deployment_date_temp
	fi
}
# Asks which user for what repo they want to work in
{
        echo -e -n "$display What repo are you working in? $CYAN";
        read;
        working_repo=${REPLY};
        echo -n ""
}
echo ""
# Changes directory to $repo
echo -e "$display Changing directory to $YELLOW./Repositories/$working_repo"
cd ./Repositories/$working_repo
# Checks out main/master branch & pulls
echo -n "$display Checking out main branch --> "
git checkout $default_branch
echo -n "$display Pulling updates from main branch --> "
git pull
# Creates new branch from user input new_branch
echo -e -n "$display Creating new branch for $YELLOW$deployment_name$NC --> "
git checkout -b $deployment_name
# Adds new features to new_branch
echo -n "$display Adding feature branches to new branches"
echo ""
{
        FILENAME=../../Branch-Names/"Features"
        LINES=$(cat $FILENAME)
        for LINE in $LINES
        do
                # If there is a merge conflict, the script shoudl stop
                if git merge origin/"$LINE" | grep -q 'CONFLICT'; then
                        echo -e "$display There is a merge conflict error for $YELLOW$LINE$NC."
                        echo "$display Aborting merge."
                        git merge --abort
                        echo "$display Stoping script."
                        # Ends script completely.
                        # When commented out, script will continue but the feature won't be merged.
#                       exit
                else
                        echo -e "$display There is no conflict for $YELLOW$LINE$NC, moving onto next step."
                fi
        done
}

## TODO: Avoid merge comments with VIM

# Merges main branch into new_branch
echo -n "$display Attempting to merge main branch into new branch --> "
git merge origin/$default_branch
# Pushes new release branch
echo -e -n "$display Pushing $YELLOW$deployment_name$NC"
echo ""
git push -u origin $deployment_name
# Changes back to initial directory
echo -n "$display Changing back to intial directory"
echo""
cd ../../
