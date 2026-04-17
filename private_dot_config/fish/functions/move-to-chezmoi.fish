function move-to-chezmoi --argument-names dir
    cp -L -r "$dir" "tmp/$dir"
    rm -rf "$dir"
    mv "tmp/$dir" "$dir"
    chezmoi add -r "$dir"
end
