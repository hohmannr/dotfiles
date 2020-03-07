#!/usr/bin/env bash

# small colortest script, credits go to https://github.com/stark/Color-Scripts
pcs() { for i in {0..7}; do echo -en "\e[${1}$((30+$i))m \u2588\u2588 \e[0m"; done; }
printf "\n%s\n%s\n\n" "$(pcs)" "$(pcs '1;')"
