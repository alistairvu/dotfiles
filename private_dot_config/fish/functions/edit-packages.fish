function edit-packages
    set PKG_FILE "$(chezmoi source-path)/.chezmoidata/packages.yaml"
    
    if type -q zed
        zed $PKG_FILE
    else
        vim $PKG_FILE
    end
end
