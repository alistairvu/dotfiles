function starship_transient_prompt_func
    # echo -n "$(starship module directory)"

    argparse --ignore-unknown status= -- $argv
    if set --query _flag_status
        set prompt_status "$(starship module status --status $_flag_status)"
    else
        set prompt_status ""
    end

    echo -n "$(starship module hostname)"
    echo -n "$(starship module directory)"

    echo "$prompt_status$(starship module character -s $_flag_status)"
end

function starship_transient_rprompt_func
    starship module time
end

starship init fish | source
enable_transience

set -gx LESSUTFCHARDEF "E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p"
set fish_greeting

# FEDORA:
if test -f /etc/fedora-release
    set -gx PATH "$HOME/.local/bin" $PATH
    set -gx MANPAGER "bat -plman"
    fzf --fish | source
    zoxide init fish | source

    # keychain!
    # keychain --eval --quiet id_ed25519 | source
    exit
end

# ARCH:
if test -f /etc/arch-release
    set -gx PATH "$HOME/.local/bin" $PATH
    set -gx MANPAGER "bat -plman"
    set -gx EDITOR nvim
    fzf --fish | source
    zoxide init fish --cmd cd | source
    mise activate fish | source

    if status --is-interactive
      # keychain --eval --quiet -Q gitgay | source
      op completion fish | source
    end
    exit
end

# MANPAGER
set -gx MANPAGER "sh -c 'col -bx | bat -plman'"
set -gx PATH "$HOME/.local/bin" $PATH

# editor
set -gx EDITOR zed --wait

# pnpm
set -gx PNPM_HOME /Users/alistair/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/alistair/.cache/lm-studio/bin

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/alistair/.opam/opam-init/init.fish' && source '/Users/alistair/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration

set -gx PATH "/Users/alistair/.pixi/bin" $PATH

eval "$(/opt/homebrew/bin/brew shellenv fish)"

if command -v ngrok &>/dev/null
    eval "$(ngrok completion)"
end

# Mole shell completion
set -l output (mole completion fish 2>/dev/null); and echo "$output" | source
set -l output (mo completion fish 2>/dev/null); and echo "$output" | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /Users/alistair/.ghcup/bin $PATH # ghcup-env

zoxide init fish --cmd cd | source

if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

fish_add_path "/Users/alistair/.bun/bin"

fzf --fish | source

set -gx HOMEBREW_NO_ENV_HINTS 1
set -x HOMEBREW_CASK_OPTS --no-quarantine

set -gx XDG_CONFIG_HOME "$HOME/.config"

op completion fish | source
true
