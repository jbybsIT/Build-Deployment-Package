# Build-Deployment-Package

This script automates a git branch merge, deployment, and cleanup.

## Usage
<details open>	<summary>Deployment Menu Script</summary>
<br>
Run `./Deployment-Menu.sh` and select which action you want to do.
</details>
<details>	<summary>Build-Deployment-Package Script</summary>
<br>
`Build-Deployment-Package.sh` <br>
This script will create a deployment branch and add all feature branches that are in the `./Branch-Names/Features` file. It will ask you which repo to work in. This repo must be cloned within the ./Repositories folder. 
</details>
<details>	<summary>Merge 2 Master Script</summary>
<br>
`Merge-2-Master.sh` <br>
This script will merge the deployment branch into master branch. It will ask you which repo to work in. This repo must be cloned within the ./Repositories folder. 
</details>
<details>	<summary>Clean Up Script</summary>
<br>
`Cleanup.sh` <br>
This script will give you options of how much you want to clean up.
Feature clean up will delete any branches that are in the ./Branch-Names/Features file.
Deepclean will delete any branches that are in the ./Branch-Names/Deep-Clean file. 
It will ask you which repo to work in. This repo must be cloned within the ./Repositories folder. 
</details>
