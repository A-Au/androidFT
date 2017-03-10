#!/bin/bash
USERNAME=$( whoami )

if [[ $1 = 'disable' ]]; then
    mv /Applications/Android\ File\ Transfer.app/Contents/Resources/Android\ File\ Transfer\ Agent.app     /Applications/Android\ File\ Transfer.app/Contents/Resources/Android\ File\ Transfer\ Agent_DISABLED.app
    mv /Users/$USERNAME/Library/Application\ Support/Google/Android\ File\ Transfer/Android\ File\ Transfer\ Agent.app    /Users/$USERNAME/Library/Application\ Support/Google/Android\ File\ Transfer/Android\ File\ Transfer\ Agent_DISABLED.app
    PID=$(ps -ef | grep [A]ndroid\ File\ Transfer\ Agent | awk '{print $2}')
    while [[ -n $PID ]]; do
        kill $PID
        PID=$(ps -ef | grep [A]ndroid\ File\ Transfer\ Agent | awk '{print $2}')
    done
    echo 'DISABLED'
elif [[ $1 = 'enable' ]]; then
    mv /Applications/Android\ File\ Transfer.app/Contents/Resources/Android\ File\ Transfer\ Agent_DISABLED.app    /Applications/Android\ File\ Transfer.app/Contents/Resources/Android\ File\ Transfer\ Agent.app
    mv /Users/$USERNAME/Library/Application\ Support/Google/Android\ File\ Transfer/Android\ File\ Transfer\ Agent_DISABLED.app   /Users/$USERNAME/Library/Application\ Support/Google/Android\ File\ Transfer/Android\ File\ Transfer\ Agent.app
    open -a /Users//Library/Application\ Support/Google/Android\ File\ Transfer/Android\ File\ Transfer\ Agent.app & disown
    echo 'ENABLED'
else
    echo 'Expected to receive "enable|diable" as an argument'
    if [[ $# -eq 0 ]]; then
        echo 'Received 0 arguments'
    else
        echo 'Received an invalid argument'
    fi
fi