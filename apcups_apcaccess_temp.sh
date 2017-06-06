#!/bin/bash

APCACCESS='/sbin/apcaccess'

function GetValue {
    localoutput=`$APCACCESS | grep ITEMP | sed 's/.*: \(.*\)$/\1/' | tr -d ' ' | cut -d. -f1`
    echo $localoutput
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Temperature"
    echo "graph_vlabel Degrees Celcius"
    echo "graph_category power"
    echo "temperature.label Temperature of APC"
    echo "graph_info Temperature of APC"
    exit 0
fi

echo "temperature.value `GetValue`"
