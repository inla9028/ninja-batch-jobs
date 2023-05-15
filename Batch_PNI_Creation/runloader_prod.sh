#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjadata/ninjadata@ninjatest -data="$1" -control=batch_pni.ctl
