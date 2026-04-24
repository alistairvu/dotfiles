function edit-packages
    set PKG_FILE "$(chezmoi source-path)/.chezmoidata/packages.yaml"
    vim $PKG_FILE
end
