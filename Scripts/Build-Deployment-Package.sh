#!/bin/bash
### Configuration Settings
# Today's date
todays_date=$(date '+%Y-%m-%d')
# Git default branch i.e. master or main
default_branch=main
display=CONSOLE

### Prompt User for Functionality
# Naming the deployment branch 
{
        read -p "$display: Is the deployment branch being deployed today, $todays_date? (Y/N) " date_user_question;
	if [ $date_user_question = Y ] || [ $date_user_question = y ];
	then 
		deployment_name=ITD-$todays_date
	else
		read -p "$display: Please enter the date of the branch's deployment: ITD-" deployment_date_temp;
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
# Changes directory to $repo
echo -n "$display: Changing directory to $working_repo"
echo ""
cd ./Repositories/$working_repo
# Checks out main/master branch & pulls
echo -n "$display: Checking out main branch --> "
git checkout $default_branch
echo -n "$display: Pulling updates from main branch --> "
git pull
# Creates new branch from user input new_branch
echo -n "$display: Creating new branch for $deployment_name --> "
git checkout -b $deployment_name
# Adds new features to new_branch
echo -n "$display: Adding feature branches to new branches"
echo ""
{
        FILENAME=../../Branch-Names/"Features"
        LINES=$(cat $FILENAME)
        for LINE in $LINES
        do
                # If there is a merge conflict, the script shoudl stop
                if git merge origin/"$LINE" | grep -q 'CONFLICT'; then
                        echo "$display: There is a merge conflict error for $LINE."
                        echo "$display: Aborting merge."
                        git merge --abort
                        echo "$display: Stoping script."
                        # Ends script completely.
                        # When commented out, script will continue but the feature won't be merged.
#                       exit
                else
                        echo "$display: There is no conflict for $LINE, moving onto next step."
                fi
        done
}

## TODO: Avoid merge comments with VIM

# Merges main branch into new_branch
echo -n "$display: Attempting to merge main branch into new branch --> "
git merge origin/$default_branch
# Pushes new release branch
echo -n "$display: Pushing $deployment_name"
echo ""
git push -u origin $deployment_name
# Changes back to initial directory
echo -n "$display: Changing back to intial directory"
echo""
cd ../../
