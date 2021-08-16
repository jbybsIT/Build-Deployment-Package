#!/bin/bash
# Bash Menu Script Example
display=$'\e[31mCONSOLE\e[0m:'
# Color variables
PURPLE=$'\e\[35m'
YELLOW=$'\e[33m'
GREEN=$'\e[32m'
BLUE=$'\e[34m'
CYAN=$'\e[36m'
NC=$'\e[0m'
BOLD="\033[1m"

echo ""
echo "Deployment Menu: What would you like to do?"
echo ""
PS3='Please enter your choice: '
options=("Create Package" "Merge to Master" "Clean Up" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Create Package")
            echo ""
	    echo "$display Running create package script..."
            bash ./Scripts/Build-Deployment-Package.sh
	    break
	    ;;
        "Merge to Master")
	    echo ""
            echo "$display Running merge to master script..."
	    bash ./Scripts/Merge-2-Master.sh
            break
	    ;;
        "Clean Up")
  	    echo ""
            echo "$display Running clean up script..."
            bash ./Scripts/Cleanup.sh
	    break
    	    ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
