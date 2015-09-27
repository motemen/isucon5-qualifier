#!/bin/sh

echo ssh isucon@isucon05 "cd ~/deploy && git pull && carton install && supervisorctl restart isucon_perl && ~/slack.pl 'deploy finished $(git rev-parse --short HEAD)'"
