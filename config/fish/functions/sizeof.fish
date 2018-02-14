function sizeof
  if test -d $argv
    dirsize $argv
  else
    filesize $argv
  end
end

function filesize
  ls -lah $argv | awk '{print $5}'
end

function dirsize
  du -sh $argv | awk '{print $1}'
end
