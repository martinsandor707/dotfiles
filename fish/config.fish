# Commands to run in interactive sessions can go here
set -x SHELL /usr/bin/fish
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != linux
        starship init fish | source
        # enable_transience
    end

    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != linux
        alias ls 'eza --icons'
    end

    fastfetch
end

# Martin changes
source /usr/share/doc/find-the-command/ftc.fish

set -x GH_CONFIG_DIR $HOME/.config/gh

alias ghp='export GH_CONFIG_DIR=/home/martin/.config/gh; gh auth status; git config --global user.name martinsandor707; git config --global user.email martinsandor707@gmail.com; git config --global --list'
alias ghw='export GH_CONFIG_DIR=/home/martin/.config/gh-work; gh auth status; git config --global user.name martin-sandor; git config --global user.email martin.sandor@serveusai.com; git config --global --list'
set -x EDITOR /usr/bin/nvim
set -x PGADMIN_DEFAULT_EMAIL "martinsandor707@gmail.com"
set -x PGADMIN_DEFAULT_PASSWORD password
