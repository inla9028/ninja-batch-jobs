#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjadata_st/ninjadata_st@NINJAT -data="$1" -control=runloader.ctl -log=ST_runloader.log -bad=ST_runloader.bad


