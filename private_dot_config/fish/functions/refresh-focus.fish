function refresh-focus --wraps='yabai -m config focus_follows_mouse autofocus' --description 'alias refresh-focus yabai -m config focus_follows_mouse autofocus'
    yabai -m config focus_follows_mouse autofocus $argv
end
