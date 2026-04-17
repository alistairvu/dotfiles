function fix_fish_history
    mv ~/.local/share/fish/fish_history ~/.local/share/fish/fish_history_bad
    strings ~/.local/share/fish/fish_history_bad > ~/.local/share/fish/fish_history
end
