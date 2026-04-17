function dotfiles --wraps='git --git-dir=/Users/alistair/dotfiles --work-tree=/Users/alistair' --wraps='git --git-dir=/Users/alistair/dotfiles --work-tree=/Users/alistair/dotfiles' --description 'alias dotfiles git --git-dir=/Users/alistair/dotfiles --work-tree=/Users/alistair/dotfiles'
    git --git-dir=/Users/alistair/dotfiles --work-tree=/Users/alistair/dotfiles $argv
end
