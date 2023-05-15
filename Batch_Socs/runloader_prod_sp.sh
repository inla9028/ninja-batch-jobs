#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjamain/ninja2004@ninjaprod1 -data="$1" -control=batch_socs_sp.ctl -errors=0
