#!/usr/bin/env bash
app=${0##*/};
if [[ $# -ne 1 ]]
then
    echo "Usage: ${app} <input-file>";
    exit;
fi
eval sqlldr ninjadata_st/ninjadata_st@NINJAT -data="$1" -control=batch_socs.ctl -errors=0
