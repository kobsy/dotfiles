function fish_prompt
  # Fully expand directories, but abbreviate home dir to ~
  set -g fish_prompt_pwd_dir_length 20
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_showcolorhints true  

  set_color -o white
  printf "%s" (prompt_pwd)
  set_color normal

  printf " (%s@%s) " (whoami) (prompt_hostname)

  printf "%s" (__fish_git_prompt "[%s]")

  echo

  echo -n "→ " 
end
