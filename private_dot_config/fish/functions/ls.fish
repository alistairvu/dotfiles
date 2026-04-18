function ls --wraps=eza --wraps='eza --icons' --wraps='eza --icons -a' --description 'alias ls eza --icons -a'
    eza --icons -a $argv
end
