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

## Functions
# Delete deployment branch function
function delete_deployment_branch () {
        echo -e "$display Deleting deployment branch..."
	cd ./Repositories/$working_repo
        git branch -d $deployment_name
        git push origin :$deployment_name
        cd ../../
	echo -e "$display Deleted deployment branch$GREEN$deployement_name" 
}
# Delete feature branches function
function delete_feature_branch () {
	echo -e "$display Deleting feature branch(es)..."
	cd ./Repositories/$working_repo
        {
        FILENAME=../../Branch-Names/"Features"
        LINES=$(cat $FILENAME)
        for LINE in $LINES
        do
                git branch -d $LINE
                git push origin :$LINE
        done
        }
        cd ../../
	echo -e "$display Deleted feature branch(es)."
}
# Deep clean function - cleans out anything in Deep-Clean file
function deep_clean_function () {
echo "$display Deep cleaning...$NC"
cd ./Repositories/$working_repo
# Deep cleans
        {
                FILENAME1=../../Branch-Names/"Deep-Clean"
                LINES1=$(cat $FILENAME1)
                for LINE1 in $LINES1
                do
                        git push origin :$LINE1
                done
        }
cd ../../
}
function wipe_features_file () {
# Clears out features file
echo "$display$NC Cleaning Features file" 
cd ./Branch-Names 
rm Features 
touch Features 
cd ../ 
echo "$display Cleaned out Features file"

}
function wipe_deepclean_file () {
# Clears out deep clean file
echo "$display$NC Cleaning Deep-Clean file"
cd ./Branch-Names
rm Deep-Clean
touch Deep-Clean
cd ..
echo "$display Cleaned out Deep-Clean file"
}

### Prompt User for Functionality
# Verifiying branch name
{
        read -p "$display Is the deployment branch$GREEN ITD-$todays_date?$NC (Y/N) $CYAN" date_user_question;
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
# Asks user if they would like to delete deployment branch
{
	read -p "$display Would you like to delete the deployment branch? (Y/N)$CYAN " delete_deploy_question;
	if [ $delete_deploy_question = Y ] || [ $delete_deploy_question = y ];
	then
		delete_deployment_branch
	else
		echo -e "$display User opt'd out of deleting $YELLOW$deployment_name"
	fi
}
# Asks user if they would like to delete feature branches
{
        read -p "$display Would you like to delete the feature branches? (Y/N) $CYAN" delete_feature_question;
        if [ $delete_feature_question = Y ] || [ $delete_feature_question = y ];
        then
                delete_feature_branch
        else
                echo "$display User opt'd out of deleting feature branches."
        fi
}
# Asks user if they would like to deep clean the repo
{
	read -p "$display Would you like to run deep clean? (Y/N)$CYAN " user_input
	if [ $user_input = Y ] || [ $user_input = y ];
	then
		deep_clean_function
	else
                echo "$display Skipped deep clean"
	fi
}
# Ask user if they would like to wipe features file
{
        read -p "$display Would you like to wipe the features file? (Y/N)$CYAN " wipe_feature_question;
        if [ $wipe_feature_question = Y ] || [ $wipe_feature_question = y ];
        then
                wipe_features_file
        else
                echo "$display User opt'd out of wiping features file."
        fi
}
# Ask user if they would like to wipe deep clean file
{
        read -p "$display Would you like to wipe deep clean file? (Y/N)$CYAN " delete_deep_question;
        if [ $delete_deep_question = Y ] || [ $delete_deep_question = y ];
        then
                wipe_deepclean_file
        else
                echo "$display User opt'd out of wiping deep clean file."
        fi
}
