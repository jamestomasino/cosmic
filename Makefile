install: bin templates man completion

clean:
	stow -t "/usr/local/bin" -D bin
	stow -t "/etc/templates" -D templates
	stow -t "/usr/share/man/man1/" -D man

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

.PHONY: bin templates man completion
