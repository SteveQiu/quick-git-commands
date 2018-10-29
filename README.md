# How to use

parse_git_branch // master or other branch
gitgraph // the graph of git commits
gitprune // it will delete branches merged to master
gitrebasemaster master // switch to master, update the master branch to the latest master in remote. it includes clean up of merged branch.
gitrebasemaster <branch-name> //switch to my-branch, rebase current branch to the remote master branch. it includes clean up of merged branch. if it has conflict you must resolve it
gitrebasemaster // rebase current branch to the remote master branch. it includes clean up of merged branch. if it has conflict you must resolve it
gitpublish // set upstream branch and create new branch remotely with existing commit, similar to git push -u origin <branch-name>
gitpublish some_other_branch// push some other branches onto repo
gitcreatebranch <branch-name> // create new branch from local master
 
 
 
 
Example 1:
gitcreatebranch myBranch
gitrebasemaster // rebase current branch, clean up merged branch
gitpublish
//do some editing
gitsave
//do some editing
gitsave
//do some editing
gitsave
//do some editing
gitsave
....
git push
 
 
Example 2:
gitcreatebranch myBranch
gitpublish
//do some editing
gitsave
//do some editing
gitsave
//do some editing
gitsave
// want to save
git push
//do some editing
gitsave
....
 
 
 
gitrebasemaster // rebase current branch, clean up merged branch
git push -f
 
Example 3 (rebase your local branch to the lastest remote master):
// go to a branch that has commits far behind in origin/master, and want to rebase the change onto the new origin/master
gitrebasemaster (your branch)
// resolve conflicts
git push -f
