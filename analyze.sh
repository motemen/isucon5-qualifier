#!/bin/sh

set -x

ssh -tt isucon02 'grep Isucon5q /var/log/nginx/access_log.tsv | alp --sum --apptime-label=taken --uri-label=dispatch'

