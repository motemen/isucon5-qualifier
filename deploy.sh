#!/bin/sh

cd ~/deploy
git pull
carton install
supervisorctl restart isucon_perl
