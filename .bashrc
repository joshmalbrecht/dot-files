### Setup github SSH authentication ###
env=~/.ssh/agent.env
agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
agent_start () {
	(umask 077; ssh-agent >| "$env")
	. "$env" >| /dev/null ; }

agent_load_env
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
	agent_start
	ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
	ssh-add
fi

unset env
### End of github SSH authentication ###

### Common Aliases ###
alias q='exit'
alias c='clear'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

### Maven Aliases ###
alias mci='mvn clean install'



