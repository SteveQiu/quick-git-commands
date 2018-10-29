#! /bin/bash

function cs(){
  cd "$1" && pwd && ls -a;
}

# show graph of git commits
function gitgraph(){
  git log --oneline --graph --decorate --all;
}
# clean up merged branches
# remove -r in MacOS
function gitprune(){
git branch --merged | egrep -v "(^\*|master|staging)" | xargs -r git branch -d && git remote prune origin;
}
# determine if the last 2 commits are duplicates
function is_pre_git_dup(){
  git log -n 2 | sed -n "/\s\s\s\s./p"|sed -e "s/\s*//" | head | uniq -d |wc -l;
}
# save commits and squash the last 2 commits if commit messages are the same
function gitsave(){
  local tmp="";
  local blank="";
  if [[ "$1" != "" ]]; then
    tmp="$1";
  else
    tmp="$(parse_git_branch)";
  fi
  #echo "$tmp";
  tmp="${tmp//[() ]/$blank}"
  git commit -am"$tmp";
 
 tmp="$(is_pre_git_dup)";
  if [[ "$tmp" == "1" ]]; then
    echo duplicate commit;
    tmp="$(parse_git_branch)";
    tmp="${tmp//[() ]/$blank}";
    git reset --mixed HEAD~2;
    git add .
    git commit -am"$tmp";
  fi
}
# rebase onto master and cleanup merged branches
function gitrebasemaster(){
  local tmp="master";
  local blank="";
  if [[ "$1" != "" ]]; then
    tmp="$1";
  else
    tmp="$(parse_git_branch)";
  fi

  tmp="${tmp//[() ]/$blank}"
  git checkout "$tmp";
  git fetch -p origin;
  gitprune;
  git rebase origin/master "$tmp";
}
# push current branch or given branch set upsteam
function gitpublish(){
  local tmp="master";
  local blank="";
  if [[ "$1" != "" ]]; then
    tmp="$1";
  else
    tmp="$(parse_git_branch)";
  fi

  tmp="${tmp//[() ]/$blank}"
  git push -u origin "$tmp";
}
# create new branch from local master
function gitcreatebranch(){
  git checkout master;
  git checkout -b "$1";
}
# list ssh config
function ssh-list(){
  sed -n '/HOST/ p' ~/.ssh/config | cut -d' ' -f2-;
}

#return the name of current branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='\u@\h:\w $(parse_git_branch) \$ '
