install: apt bin templates man completion files efingerd menu postfix updatemotd source
.PHONY:  apt bin templates man completion files efingerd menu postfix updatemotd source

apt:
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	if [ ! -f "/etc/apt/sources.list.d/yarn.list" ]; then \
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list; \
	fi
	xargs -a pkglist sudo apt install -y

source:
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

bin:
	stow -t "/usr/local/bin" bin

templates:
	mkdir -p "/etc/templates"
	stow -t "/etc/templates" templates

man:
	mkdir -p "/usr/share/man/man1"
	stow -t "/usr/share/man/man1" man

completion:
	mkdir -p "/etc/bash_completion.d"
	stow -t "/etc/bash_completion.d" completion

files:
	mkdir -p "/usr/share/games/fortunes"
	cd files && stow -t "/usr/share/games/fortunes" fortunes

efingerd:
	mkdir -p "/etc/efingerd"
	stow -t "/etc/efingerd" efingerd

updatemotd:
	mkdir -p "/etc/update-motd.d"
	stow -t "/etc/update-motd.d" update-motd
	sudo chown -R root /etc/update-motd.d

menu:
	stow -t "/etc" menu

postfix:
	if ! grep -q 'transport_maps' "/etc/postfix/main.cf"; then \
		printf "transport_maps = hash:/etc/postfix/transport" >> "/etc/postfix/main.cf"; \
	fi
	stow -t "/etc/postfix" postfix
	sudo chown root /etc/postfix/transport
	postmap /etc/postfix/transport
	postfix reload

uninstall:
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

