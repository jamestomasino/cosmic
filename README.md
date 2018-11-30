# cosmic.voyage scripts

## bin

For admin:

- `cosmic-backup` cron-run backup of /var/gopher to git repo
- `cosmic-rss` cron-run creation of rss feed for web and gopher
- `cosmic-ship` create a new ship and assign it to a given user
- `cosmic-user` create a new user and scaffold them into the story
- `cosmic-web` cron-run creation of html version of the story

For users:

- `cosmic-log` aliased as `log` - submit messages to the QEC relay
- `cosmic-motd` aliased as `motd` - pretty-prints the motd
- `cosmic-roster` aliased as `roster` - show current users and their ships

## files

- `motd` message of the day, records recent updates to the system
- `favicon.ico` website favicon for https://cosmic.voyage

## templates

- `web-header.tmpl` - template for web generation
- `newship.tmpl` - email template for adding new ship for user
- `welcomeemail.tmpl` - email template for new users added to system

## manpages

- `cosmic-log` aliased as `log`

## bash-completion

- `cosmic-log` aliased as `log`
