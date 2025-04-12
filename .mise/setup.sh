gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 0x7413A06D
curl https://mise.jdx.dev/install.sh.sig | gpg --decrypt > install.sh
# ensure the above is signed with the mise release key
sh ./install.sh

if [ -n "$ZSH_VERSION" ]; then
   # assume Zsh
   echo 'eval "$(mise activate zsh)"' >> "${ZDOTDIR-$HOME}/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
   # assume Bash
   echo 'eval "$(mise activate bash)"' >> ~/.bashrc
else
   # assume something else
   echo 'shell not supported, please add the following line to your shell config file'
   echo 'eval "$(mise activate bash)"'
   echo 'or'
   echo 'eval "$(mise activate zsh)"'
   echo 'or'
   echo 'eval "$(mise activate fish)"'
   echo 'or'
   echo 'eval "$(mise activate tcsh)"'
   echo 'or'
   echo 'eval "$(mise activate ksh)"'
fi
