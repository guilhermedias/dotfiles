# My oh-my-zsh theme based on Bira - https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir_pref='%~'

if [[ "$ITERM_PROFILE" == "Trainer" ]]; then
    current_dir_pref='%1d'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}${current_dir_pref}%{$reset_color%}'

local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭─○ ${user_host} 🏹 ${current_dir} ${git_branch}
╰─○ %B${user_symbol}%b "

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

  configure_right_justified_prompt
}

function calculate_elapsed_time {
  if [[ $start_time ]]; then
    command_elapsed_time=$(($(current_time_millis) - start_time))
    unset start_time
  else
    unset command_elapsed_time
  fi
}

function format_elapsed_time {
  if [[ $command_elapsed_time ]]; then
    milliseconds=$(calculate_milliseconds $command_elapsed_time)
    seconds=$(calculate_seconds $command_elapsed_time)
    minutes=$(calculate_minutes $command_elapsed_time)
    hours=$(calculate_hours $command_elapsed_time)

    formatted_milliseconds=$(adjust_to_field_size milliseconds 3)
    formatted_seconds=$(adjust_to_field_size seconds 2)
    formatted_minutes=$(adjust_to_field_size minutes 2)
    formatted_hours=$(adjust_to_field_size hours 2)

    formatted_elapsed_time="${formatted_hours}:${formatted_minutes}:${formatted_seconds}.${formatted_milliseconds}"
  else
    unset formatted_elapsed_time
  fi
}

function configure_right_justified_prompt {
  if [[ $formatted_elapsed_time ]]; then
    RPS1="%{$terminfo[bold]$fg[white]%}${formatted_elapsed_time}%{$reset_color%}"
  else
    RPS1=""
  fi

}

function current_time_millis {
  echo $(python -c 'import time; print(int(round(time.time() * 1000)))')
}

function calculate_milliseconds {
  echo $(($1 - (($1 / 1000) * 1000)))
}

function calculate_seconds {
  echo $((($1 / 1000) % 60))
}

function calculate_minutes {
  echo $((($1 / 60000) % 60))
}

function calculate_hours {
  echo $((($1 / 360000) % 60))
}

function adjust_to_field_size {
  echo $(printf "%0$2d" $1)
}
