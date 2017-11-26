{
  programs.bash.interactiveShellInit = ''
    CDPATH=".:~/Development:~/Development/resources:~"

    shopt -s histappend cmdhist lithist

    # If shell is interactive, disable START/STOP output control.
    # This allows Ctrl-S to trigger i-search.
    if [[ $- = *i* ]]; then
      # -ixon : Disable START/STOP output control.
      # This allows Ctrl-S to trigger i-search.
      stty -ixon
    fi

    unset -v MAILCHECK

    HISTTIMEFORMAT='%F %T '
    HISTCONTROL=erasedups:ignorespace
    HISTSIZE=10000
    HISTFILESIZE=20000
    HISTIGNORE='jobs:[fb]g:history:gst:tls:fgg'

    shopt -s no_empty_cmd_completion

    showpath() {
      col_bold="\033[30;01m"
      col_reset="\033[39;49;00m"

      printf '%bPATH%b:\n%s\n' "$col_bold" "$col_reset" "''${PATH//:/$'\n'}"
    }

    # jump to Bash builtin documentation
    man () {
      case "$(type -t "$1")" in
        builtin)
          local pattern="^ *$1"

          if bashdoc_match "$pattern \+[-[]"; then
            command man bash | less --pattern="$pattern +[-[]"
          elif bashdoc_match "$pattern\b"; then
            command man bash | less --pattern="$pattern[[:>:]]"
          else
            command man bash
          fi
          ;;
        keyword)
          command man bash | less --hilite-search --pattern='^SHELL GRAMMAR$'
          ;;
        *)
          command man "$@"
          ;;
      esac
    }

    bashdoc_match() {
      command man bash | col -b | grep -l "$1" > /dev/null
    }

    fdoc() {
      curl dict://dict.org/d:$1:foldoc
    }
  '';
}
