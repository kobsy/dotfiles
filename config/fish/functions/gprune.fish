function gprune
  for branch in (git branch --merged master)
    set merged (string trim $branch)
    if test $merged = "master"
      echo "Skipping master branch"
    else
      # echo "Deleting merged branch: $merged"
      git branch -d $merged
    end
  end
end
