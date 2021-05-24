# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

CASE_SENSITIVE="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

# Misc
alias vi=nvim
alias gitsub="git submodule update --init --recursive"
alias pypath='export PYTHONPATH=$(pwd):$PYTHONPATH'

# Conda
. /opt/conda/etc/profile.d/conda.sh
conda activate base

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keep separate shell histories for each terminal
unsetopt inc_append_history
unsetopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
