#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjadata/ninjadata@ninjaprod1 -data="$1" -control=runloader.ctl -log=runloader.log -bad=runloader.bad

