#
# Set up home directory for Volta.
#
set -gx volta_home '/users/tni/.volta'

#
# Add directories to PATH.
#
set -U fish_user_paths $fish_user_paths ~/.cargo/bin '$volta_home/bin'

if status --is-interactive
  #
  # Prefer the neovim fork of vim.
  #
  #   https://neovim.io/
  #
  abbr -a    vi nvim
  abbr -a   vim nvim
  setenv EDITOR nvim

  #
  # Replace a new interactive shell with tmux, using the first window as the
  # target window.
  #
  if test -z "$TMUX"
    tmux new-session -A -s main; and exec true
  end

  #
  # Consistency when opening a file.
  #
  # From the terminal:
  #   e
  #
  # From vim:
  #   :e
  #
  abbr -a e nvim

  #
  # Prefer exa, which is "a modern replacement for ls".
  #
  #   https://the.exa.website/
  #
  if command -v exa > /dev/null
  	abbr -a ls 'exa'
  	abbr -a ll 'exa -l'
  else
  	abbr -a ll 'ls -l'
  end

  #
  # Prefer bat, which is a better version of cat.
  #
  #   https://github.com/sharkdp/bat
  #
  if command -v bat > /dev/null
    abbr -a cat 'bat'
  end

  function fish_greeting
    echo
    set_color green

    echo -n '    '
    set hour (date +%H)
    if [ $hour -lt 12 ]
      echo -n 'Good morning, '
    else if [ $hour -lt 18 ]
      echo -n 'Good afternoon, '
    else
      echo -n 'Good evening, '
    end
    echo 'Teddy.'

    echo
    set_color normal
  end

  function fish_prompt
    # Print the time of day in a muted color.
    set_color brblack
    echo -n '['(date "+%H:%M")'] '

    # Print the current directory name.
    set_color yellow
    if [ $PWD != $HOME ]
      echo -n (basename $PWD)
    else
      echo -n '~'
    end

    # Print Git information, when available
    set_color green
    printf '%s ' (__fish_git_prompt)

    # Print the prompt symbol.
    set_color red
    echo -n '| '

    set_color normal
  end

  #
  # Setup autojump, a "cd command that learns". Its command from the shell is
  # mapped to "j".
  #
  #   https://github.com/wting/autojump
  #
  if test -f /usr/local/share/autojump/autojump.fish;
    source /usr/local/share/autojump/autojump.fish;
  end

  #
  # Adds color to man pages.
  #
  #   http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
  #
  setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
  setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
  setenv LESS_TERMCAP_me \e'[0m'           # end mode
  setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
  setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
  setenv LESS_TERMCAP_ue \e'[0m'           # end underline
  setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
end

