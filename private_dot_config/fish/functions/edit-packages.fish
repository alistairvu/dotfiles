function edit-packages
  set -l os (uname)
  if test "$os" = Darwin
    set PKG_FILE "$(chezmoi source-path)/.chezmoidata/darwin_packages.yaml"
  else if test "$os" = Linux; and test -f /etc/arch-release
    set PKG_FILE "$(chezmoi source-path)/.chezmoidata/arch_packages.yaml"
  else
    echo "Unsupported OS: $os"
    return
  end
  $EDITOR $PKG_FILE
end
