if [ -f /etc/bashrc ]; then
	. /etc/bashrc 
fi

#Gitの補完機能
if [ -f .git-.git-completion.bash ]; then
	source .git-completion.bash
fi


#show current git branch name
git_branch() {
  echo $(git branch --no-color 2>/dev/null | sed -ne "s/^\* \(.*\)$/\1/p")
}
export PS1='\[\e[1;32m\][\u@\h]\[\e[0;33m\]\w/ \[\e[1;32m\]$(git_branch)\[\e[0m\]\r\n$ '


#color ls
case "${OSTYPE}" in
darwin*)
  alias ll='ls -alF -G'
  ;;
*)
  alias ll='ls -alF --color=auto'
  ;;
esac

#rbenv
if [ -d $HOME/.rbenv/bin ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

#alias
alias hs=history
alias l=less
alias gr='grep --color=auto'
alias g=git
alias src=source
alias j=jobs
alias k1='kill %1'
alias k2='kill %2'
alias r=rails


#.bashrc.local
if [ -f .bashrc.local ]; then
  source .bashrc.local
fi
