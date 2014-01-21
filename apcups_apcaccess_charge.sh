#!/bin/bash

# This plugin requires 'bc'

# Enviroment config variables needed
## [apcups_*]
## env.snmpcommunity foo
## env.upsip $ip (or hostname, however you access your UP)

APCACCESS='/sbin/apcaccess'

function GetValue {
    localoutput=`$APCACCESS | grep BCHARGE | sed 's/.*: \(.*\) Percent$/\1/' | tr -d ' ' | cut -d. -f1`
    echo $localoutput
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Battery Charge"
    echo "graph_vlabel Percent"
    echo "graph_category power"
    echo "charge.label Percentage of Battery Charge"
    echo "graph_info Percentage of Battery Charge"
    exit 0
fi

echo "charge.value `GetValue`"
