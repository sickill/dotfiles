case "$TERM" in
  xterm*|rxvt*)
    preexec () {
      print -Pn "\e]0;%~: $1\a"  # xterm
    }

    precmd () {
      print -Pn "\e]0;%~\a"  # xterm
      # echo -ne "\a"
    }
    ;;

  screen*)
    # preexec () {
    #   local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}
    #   echo -ne "\ek$CMD\e\\"
    #   print -Pn "\e]0;%~: $1\a"  # xterm
    # }

    # precmd () {
    #   echo -ne "\ekzsh\e\\"
    #   print -Pn "\e]0;%~\a"  # xterm
    # }
    ;;
esac
