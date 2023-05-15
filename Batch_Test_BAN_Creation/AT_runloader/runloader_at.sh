#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjadata_at/ninjadata_at@NINJAT -data="$1" -control=runloader.ctl -log=AT_runloader.log -bad=AT_runloader.bad


