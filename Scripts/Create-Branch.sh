#!/bin/bash
# Asks user for new branch name
{
	echo -n "Console: What do you wish to call the new branch? ";
	read;
	new_branch=${REPLY};
	echo -n ""
}
# Asks which user for what repo they want to work in
{
	echo -n "Console: What repo are you working in? ";
	read;
	repo=${REPLY};
	echo -n ""
}	
echo ""
echo ""
# Changes directory to $repo
echo -n "Console: Changing directory to $repo"
echo ""
cd $repo
# Checks out main/master branch & pulls
echo -n "Console: Checking out main branch --> "
git checkout main
echo -n "Console: Pulling updates from main branch --> "
git pull
# Creates new branch from user input new_branch
echo -n "Console: Creating new branch for $new_branch --> "
git checkout -b $new_branch
# Adds new features to new_branch
echo -n "Console: Adding feature branches to new branches"
echo ""
{
	FILENAME=../"Features"
	LINES=$(cat $FILENAME)
	for LINE in $LINES
	do
		# If there is a merge conflict, the script shoudl stop
        	if git merge origin/"$LINE" | grep -q 'CONFLICT'; then
			echo "Console: There is a merge conflict error for $LINE."
			echo "Console: Aborting merge."
			git merge --abort
			echo "Console: Stoping script."
			# Ends script completely.
			# When commented out, script will continue but the feature won't be merged.
#			exit
		else
			echo "Console: There is no conflict for $LINE, moving onto next step."
		fi
	done
}

## TODO: Avoid merge comments with VIM

# Merges main branch into new_branch
echo -n "Console: Attempting to merge main branch into new branch --> "
git merge origin/main
# Pushes new release branch
echo -n "Console: Pushing $new_branch"
echo ""
git push -u origin $new_branch
# Changes back to initial directory
echo -n "Console: Changing back to intial directory"
echo""
cd ..

