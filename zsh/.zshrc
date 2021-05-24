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

# ECR Login
alias ecr-login='eval $\(aws ecr get-login --no-include-email --region us-east-1 \)'

# Misc
alias gitsub="git submodule update --init --recursive"
alias pypath='export PYTHONPATH=$(pwd):$PYTHONPATH'
alias vi='PYTHONPATH=$(pwd):$PYTHONPATH nvim'


# Kubernetes
alias kc=kubectl
alias kctx="kubectl config use-context"
alias kns='f() { kubectl config set-context --current --namespace="$1" }; f'
source <(kubectl completion zsh)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kylekosic/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kylekosic/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kylekosic/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kylekosic/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate dev

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keep separate shell histories for each terminal
unsetopt inc_append_history
unsetopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

