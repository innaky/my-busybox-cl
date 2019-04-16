# my-busibox-cl
An small generic binary in common lisp.

## Usage:

You need install cl-launch

```bash
## Install the necesary package
(root) > apt install cl-launch

## Create the basic directories
(user) > mkdir ~/bin
(user) > mkdir ~/common-lisp

## clone repository
(user) > git clone https://github.com/innaky/my-busibox-cl.git

## Change the name of repository for functionality
(user) > mv my-busibox-cl my-scripts
(user) > mv my-scripts ~/common-lisp
(user) > cd common-lisp/my-scripts

## Install and use
(user) > make install
(user) > my-scripts my-scripts available commands: block-screen continue-firefox firefox help kill-firefox main stop-firefox symlink
(user) > my-scripts firefox &
(user) > my-scripts kill-firefox
(user) > my-scripts firefox --private &
(user) > my-scripts kill-firefox
```

## Author

* ebzzry (https://ebzzry.io/en/script-lisp/)

# Small modification

* Innaky (innaky@protonmail.com)

## Copyright

Copyright (c) 2019 Innaky (innaky@protonmail.com)
