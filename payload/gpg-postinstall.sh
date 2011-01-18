#!/bin/sh

# Fix a bug with an old GPGTools installation
	chown -R $USER:Staff $HOME/.gnupg

# Clean up
  osascript scripts/remove-gpg-agent-login-item.scpt
  rm -rf /Applications/start-gpg-agent.app

# Also clean up bad GPGTools behaviour:
  [ -h "$HOME/.gnupg/S.gpg-agent" ] && rm -f "$HOME/.gnupg/S.gpg-agent"
  [ -h "$HOME/.gnupg/S.gpg-agent.ssh" ] && rm -f "$HOME/.gnupg/S.gpg-agent.ssh"

# Add some links
  rm -f /usr/local/bin/gpg2; ln -s /usr/local/MacGPG2/bin/gpg2 /usr/local/bin/gpg2
  [ ! -e /usr/local/bin/gpg ] && ln -s /usr/local/MacGPG2/bin/gpg2 /usr/local/bin/gpg

# Create a new gpg.conf if none is existing from the skeleton file
if ( ! test -e $HOME/.gnupg/gpg.conf ) then
	echo "Create!"
	mkdir -p $HOME/.gnupg
	chown -R $USER:Staff $HOME/.gnupg
	cp /usr/local/share/gnupg/options.skel $HOME/.gnupg/gpg.conf
fi

killall gpg-agent
echo "done."
