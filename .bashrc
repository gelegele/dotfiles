#Gitの補完機能
if [ -f .git-.git-completion.bash ]; then
	source .git-completion.bash
fi
#Gitのブランチ名表示
if [ -f  .git-prompt.sh ]; then
	source .git-prompt.sh
	#Cygwinのタイトルバーにカレントディレクトリ名を表示させる
	#PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/} $(__git_ps1 " ( %s )")\007"'
	#PS1='\033[00;32m\]\u@\h \033[00;33m\]\w\033[01;31m\]$(__git_ps1 " %s")\n\033[0m\]\$ '
	#PS1='\033[00;32m\]\u@\h \033[00;33m\]\w\033[01;31m\]\n\033[0m\]\$ '
fi

alias ll='ls -alF --color=auto'
alias hs=history
#alias l=less
alias gr='grep --color=auto'
alias g=git
alias src=source
alias j=jobs
alias k1='kill %1'
alias k2='kill %2'
alias r=rails


#ローカル設定ファイルの読み込み
if [ -f .bashrc.local ]; then
  source .bashrc.local
fi
