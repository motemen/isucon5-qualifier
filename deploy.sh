#!/bin/sh

ssh isucon@isucon05 "cd ~/deploy && git pull && carton install && supervisorctl restart isucon_perl"
