#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjateam/ninjateam@ninjaprod1 -data="$1" -control=hgu_tmp_clone.ctl


