# My oh-my-zsh theme based on Bira - https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'

local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─○ ${user_host} ${current_dir} ${git_branch}
╰─○ %B${user_symbol}%b "

RPS1="%*"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%}]"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}%B✓%b"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}%B✗%b"

# Runs before each command
function preexec {
  start_time=$(current_time_millis)
}

# Runs after each command
function precmd {
  # Set command_elapsed_time
  calculate_elapsed_time

  # Set formatted_elapsed_time
  format_elapsed_time
}

function current_time_millis {
  echo $(python -c 'import time; print(int(round(time.time() * 1000)))')
}

function calculate_elapsed_time {
  if [[ $start_time ]]; then
    command_elapsed_time=$(($(current_time_millis) - start_time))
    unset start_time
  else
    command_elapsed_time=''
  fi
}

function format_elapsed_time {
  if [[ $command_elapsed_time != '' ]]; then
    decimal_millis=$(calculate_decimal_millis $command_elapsed_time)
    seconds=$(calculate_seconds $command_elapsed_time)
    minutes=$(calculate_minutes $command_elapsed_time)
    formatted_elapsed_time='Batatinha'
  else
    formatted_elapsed_time=''
  fi
}

function calculate_decimal_millis {
  echo $(($1 - (($1 / 1000) * 1000)))
}

function calculate_seconds {
  echo $((($1 / 1000) % 60))
}

function calculate_minutes {
  echo $((($1 / 1000 / 60) % 60))
}
