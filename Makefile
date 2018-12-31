install: bin templates man completion files

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

uninstall:
	stow -t "/usr/local/bin" -D bin
	stow -t "/etc/templates" -D templates
	stow -t "/usr/share/man/man1/" -D man
	stow -t "/etc/bash_completion.d" -D completion
	cd files && stow -t "/usr/share/games/fortunes" -D fortunes

.PHONY: bin templates man completion files
