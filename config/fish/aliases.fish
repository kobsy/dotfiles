### bundler
function b
  bundle $argv
end

function be
  bundle exec $argv
end

### ls
function ls
  command ls -G $argv
end

function l
  command ls -l $argv
end

### psql
function p
  psql -hlocalhost $argv
end

### rbenv
function rb
  rbenv local $argv
end

function rb-
  rbenv local --unset $argv
end

### rails
function rst
  touch tmp/restart.txt $argv
end

function brs
  bundle exec rails s $argv
end

function brc
  bundle exec rails c $argv
end

function brg
  bundle exec rails g $argv
end

function migrate
  bundle exec rake db:migrate $argv
end

# Not ideal to overwrite `test` command in fish
# alias test="be rake test"
# alias test:all="be rake test:all"


### s3cmd
function s3
  s3cmd $argv
end

### git
function g
  git checkout $argv
end

function s
  git status $argv
end

function ga
  git add $argv
end

function gb
  git checkout -b $argv
end

function gc
  git commit -m $argv
end

function gc0
  git commit --allow-empty -m $argv
end

function gca
  git add .; and git commit -am $argv
end

function gss
  git stash save -u $argv
end

function gsp
  git stash pop $argv
end

function grc
  git rebase --continue $argv
end

function gl
  git log --color --date=relative --format=format:'%C(cyan)%h%C(reset) %C(green)%ad %C(blue)(%an)%C(reset) %C(yellow)%d %C(reset)%s' $argv
end

function gl1
  gl -1 | cat $argv
end

function gcommits
  git shortlog -ns $argv
end

function gm
  git merge --ff-only $argv
end

function gp
  git push --tags $argv
end

function gu
  git pull --ff-only --tags $argv
end

function gg
  git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(cyan)%h %C(green)%ad %C(yellow)%d %C(reset)%s %C(blue)(%an)%C(reset)' $argv
end

function gbr
  git branch $argv
end

function gtrsh
  git checkout -- $argv
end

function gcopy
  gl --pretty="%s" -1 | pbcopy
end


function shadowprint
  echo -e "\033[90m$argv\033[0m"
end

function gbranch
  set -g current_branch (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
end



# Git Fetch and Merge; delete the branch upon success
function gfmerge!
  gf $argv[1]
  gmerge! $argv
end

# Git Fetch and Merge
function gfmerge
  gf $argv[1]
  gmerge $argv
end

# Git Fetch
function gf
  if test (count $argv) -gt 0
    shadowprint "git fetch"
    git fetch

    # If the branch exists, delete it to be sure we've got the latest
    git show-branch $argv[1] > /dev/null ^&1; and gdelete $argv[1]

    shadowprint "git checkout -b $argv[1] origin/$argv[1]"
    git checkout -b $argv[1] origin/$argv[1]
  else
    shadowprint "git fetch --prune"
    git fetch --prune
  end
end

# Git Delete the branch locally
function gdelete
  shadowprint "git branch -D $argv[1]"
  git branch -D $argv[1]
end

# Git Merge; delete the branch upon success
function gmerge!
  if test (count $argv) -lt 1
    echo "USAGE: gmerge! topic-branch [dev]"
  else
    gmerge $argv; or return 1
    gdelete! $argv[1]
  end
end

# Git Merge: rebases topic branch before merging
function gmerge
  if test (count $argv) -lt 1
    echo "USAGE: gmerge topic-branch [dev]"
  else
    shadowprint "git checkout $argv[1]"
    git checkout $argv[1]; or return 1

    if test (count $argv) -lt 2
      set -l target_branch "dev"
    else
      set -l target_branch "$argv[2]"
    end

    shadowprint "git rebase $target_branch"
    git rebase $target_branch; or return 1

    shadowprint "git checkout $target_branch"
    git checkout $target_branch

    shadowprint "git merge --ff-only $argv[1]"
    git merge --ff-only $argv[1]; or return 1
  end
end

function gs
  if test (count $argv) -gt 0
    git show $argv
  else
    gbranch
    git show $current_branch
  end
end

function gd
  if test (count $argv) -gt 0
    git diff $argv
  else
    git diff --cached
  end
end

function ggrp
  gl --grep=$argv[1]
end

function gfm
  gf $argv
  gm FETCH_HEAD
end

function gpo
  # pushes the current branch; whatever that is
  gbranch
  gp origin $current_branch $argv
end

function gpo!
  # force pushes the current branch, whatever that is
  gbranch
  gp -f --no-verify origin $current_branch $argv
end

function guo
  # pulls the current branch from origin
  gbranch
  gu origin $current_branch $argv
end

