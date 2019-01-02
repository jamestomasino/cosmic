install: apt bin templates man completion files efingerd menu postfix

apt:
	xargs -a pkglist sudo apt install -y

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
	cd files && stow -t "/usr/share/games/fortunes" -D fortunes

.PHONY: bin templates man completion files efingerd menu postfix
