#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjateam/ninjateam@ninjaprod1 -data="$1" -control=hgu_tmp_replace.ctl -log=hgu_tmp_replace.log -bad=hgu_tmp_replace.bad
