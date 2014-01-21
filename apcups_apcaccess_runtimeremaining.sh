#!/bin/bash

# This plugin requires 'bc'

# Enviroment config variables needed
## [apcups_*]
## env.snmpcommunity foo
## env.upsip $ip (or hostname, however you access your UP)

APCACCESS='/sbin/apcaccess'

function GetValue {
    localoutput=`$APCACCESS | grep TIMELEFT | sed 's/.*: \(.*\) Minutes$/\1/' | tr -d ' ' | cut -d. -f1`
    echo $localoutput
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Battery Runtime"
    echo "graph_vlabel Minutes"
    echo "graph_category power"
    echo "runtime.label Minutes of Battery Runtime"
    echo "graph_info Battery Runtime in Minutes"
    exit 0
fi

echo "runtime.value `GetValue`"
