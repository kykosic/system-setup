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
alias ecr-login2='eval $\(aws ecr get-login --no-include-email --region ap-northeast-1 \)'

# Misc
alias vi=nvim
alias gitsub="git submodule update --init --recursive"

# Kubernetes configs
alias kc1='kubectl --kubeconfig ~/.kube/config-devportal-east-cluster'
alias kc2='kubectl --kubeconfig ~/.kube/config-prodportal-east-cluster'
alias kc3='kubectl --kubeconfig ~/.kube/config-dev-hpc-east'
alias kc4='kubectl --kubeconfig ~/.kube/config-prod-hpc-east'
alias kc5='kubectl --kubeconfig ~/.kube/config-prod-hpc-japan-1'
alias gk1='kubectl --kubeconfig ~/.kube/config-dev-hpc-us-central1-f'
alias gk2='kubectl --kubeconfig ~/.kube/config-prod-hpc-us-central1-c'
alias helm1='helm --kubeconfig ~/.kube/config-devportal-east-cluster'
alias helm2='helm --kubeconfig ~/.kube/config-prodportal-east-cluster'
alias helm3='helm --kubeconfig ~/.kube/config-dev-hpc-east'
alias helm4='helm --kubeconfig ~/.kube/config-prod-hpc-east'
alias helm5='helm --kubeconfig ~/.kube/config-prod-hpc-japan-1'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate dev

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home

# Node
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keep separate shell histories for each terminal
unsetopt inc_append_history
unsetopt share_history
