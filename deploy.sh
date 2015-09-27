#!/bin/sh

set -x

ssh -tt isucon02 'sudo su - isucon sh -c "cd ~/deploy && git pull && cd perl && ~/.local/perl/bin/carton install" && sudo systemctl restart isuxi.perl.service'
