#!/bin/sh

# turn off automatic updating
date -R > /usr/src/wpscan/data/.last_update

# run wpscan command with arguments
exec /usr/src/wpscan/wpscan.rb --no-banner $@
