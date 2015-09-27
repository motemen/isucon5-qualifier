#!/bin/sh

set -x

ssh -tt isucon02 'tail -F /var/log/syslog'
