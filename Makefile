help:
	@echo "targets:"
	@awk -F '#' '/^\w+:.*?#/ { print $0 }' $(MAKEFILE_LIST) \
	| sed -n 's/^\(.*\): \(.*\)#\(.*\)/  \1|-\3/p' \
	| column -t  -s '|'

install: apt bin templates man completion files efingerd menu postfix updatemotd source # install everything
.PHONY:  help apt bin templates man completion files efingerd menu postfix updatemotd source

apt: # install all apt packages
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	if [ ! -f "/etc/apt/sources.list.d/yarn.list" ]; then \
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list; \
	fi
	xargs -a pkglist sudo apt install -y

source: # clone all manual source packages to /var/packages
	@while IFS= read -r line; do \
		name=$$(printf "%s" "$$line" | awk -F "\t" '{print $$1}'); \
		repo=$$(printf "%s" "$$line" | awk -F "\t" '{print $$2}'); \
		dir="/var/packages/$${name}"; \
		if [ ! -d "$$dir" ]; then \
			mkdir -p "$$dir"; \
			git clone "$$repo" "$$dir"; \
		else \
			printf "%s already cloned\\n" "$${name}"; \
		fi; \
	done < "pkglist-source"

bin: # link bin scripts to /usr/local/bin
	stow -t "/usr/local/bin" bin

templates: # link template files
	mkdir -p "/etc/templates"
	stow -t "/etc/templates" templates

man: # link system man pages
	mkdir -p "/usr/share/man/man1"
	stow -t "/usr/share/man/man1" man

completion: # add bash completions
	mkdir -p "/etc/bash_completion.d"
	stow -t "/etc/bash_completion.d" completion

files: # link miscellaneous files
	mkdir -p "/usr/share/games/fortunes"
	cd files && stow -t "/usr/share/games/fortunes" fortunes

efingerd: # install finger scripts
	mkdir -p "/etc/efingerd"
	stow -t "/etc/efingerd" efingerd

updatemotd: # link motd files
	mkdir -p "/etc/update-motd.d"
	stow -t "/etc/update-motd.d" update-motd
	sudo chown -R root /etc/update-motd.d

menu: # install the system interactive menu
	stow -t "/etc" menu

postfix: # set up postfix for tilde-only email
	if ! grep -q 'transport_maps' "/etc/postfix/main.cf"; then \
		printf "transport_maps = hash:/etc/postfix/transport\n" >> "/etc/postfix/main.cf"; \
		printf "smtpd_recipient_restrictions = check_sender_access hash:/etc/postfix/access, reject" >> "/etc/postfix/main.cf"; \
	fi
	stow -t "/etc/postfix" postfix
	sudo chown root /etc/postfix/transport
	sudo chown root /etc/postfix/access
	postmap /etc/postfix/transport
	postmap /etc/postfix/access
	postfix reload

uninstall: # uninstall everything we've installed from this repo
	stow -t "/usr/local/bin" -D bin
	stow -t "/etc/templates" -D templates
	stow -t "/usr/share/man/man1/" -D man
	stow -t "/etc/bash_completion.d" -D completion
	stow -t "/etc/efingerd" -D efingerd
	stow -t "/etc" -D menu
	stow -t "/etc/postfix" -D postfix
	stow -t "/etc/update-motd.d" -D update-motd
	stow -t "/etc" -D menu
	cd files && stow -t "/usr/share/games/fortunes" -D fortunes

