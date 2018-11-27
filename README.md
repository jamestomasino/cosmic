# cosmic.voyage scripts

## bin

### Administration

- `cosmic-backup` cron-run backup of /var/gopher to git repo
- `cosmic-rss` cron-run creation of rss feed for web and gopher
- `cosmic-ship` create a new ship and assign it to a given user
- `cosmic-user` create a new user and scaffold them into the story
- `cosmic-web` cron-run creation of html version of the story

### User

- `cosmic-log` aliased as `log` - submit messages to the QEC relay
- `cosmic-roster` aliased as `roster` - show current users and their ships
- `cosmic-motd` aliased as `motd` - pretty-prints the motd

## files

- `motd` message of the day, records recent updates to the system

## templates

- `web-header.tmpl` - template for web generation
- `newship.tmpl` - email template for adding new ship for user
- `welcomeemail.tmpl` - email template for new users added to system
