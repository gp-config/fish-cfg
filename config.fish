if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

###########
# sources #
###########
source ~/.profile
# source /asdf-vm/src/asdf-0.9.0/asdf.fish
source /home/gp/asdf-vm/src/asdf-0.9.0/asdf.fish


###########
# aliases #
###########

# alias e='hx'
alias lg='lazygit'
alias g='lazygit'
alias e='/home/gp/.cargo/bin/neovide'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
