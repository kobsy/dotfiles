function fish_prompt
  # Fully expand directories, but abbreviate home dir to ~
  set -g fish_prompt_pwd_dir_length 20
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_showcolorhints true  

  set_color -o white
  printf "%s" (prompt_pwd)
  set_color normal

  printf " (%s@%s) " (whoami) (prompt_hostname)

  if jj show &> /dev/null;
    # printf "[%s]" (jj show -T 'self.parents().map(|c| c.change_id().shortest() ++ surround("(", ")", c.branches().join(","))).join(",") ++ ">" ++ self.change_id().shortest()')
  else;
    printf "%s" (__fish_git_prompt "[%s]")
  end

  echo

  echo -n "→ " 
end
