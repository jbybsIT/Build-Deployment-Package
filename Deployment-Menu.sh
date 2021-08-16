#!/bin/bash
# Bash Menu Script Example
input=$1
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
	    echo "CONSOLE: Running create package script..."
            bash ./Scripts/Build-Deployment-Package.sh
	    break
	    ;;
        "Merge to Master")
	    echo ""
            echo "CONSOLE: Running merge to master script..."
	    bash ./Scripts/Merge-2-Master.sh
            break
	    ;;
        "Clean Up")
  	    echo ""
            echo "CONSOLE: Running clean up script..."
            bash ./Scripts/Cleanup.sh
	    break
    	    ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
