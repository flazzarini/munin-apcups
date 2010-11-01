#!/bin/bash

# This plugin requires 'bc'

# Enviroment config variables needed
## [apcups_*]
## env.snmpcommunity foo
## env.upsip $ip (or hostname, however you access your UP)

function getOIDvalue {
    localoutput=`echo $* | sed 's/.*: \(.*\)$/\1/' `
    unformatted_runtime=`echo $localoutput | tr -d '()' | cut -d" " -f1`
    echo "scale=2; $unformatted_runtime/100/60" | bc
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Battery Runtime"
    echo "graph_vlabel Minutes"
    echo "graph_category power"
    echo "runtime.label Minutes of Battery Runtime"
    echo "graph_info Battery Runtime in Minutes"
    exit 0
fi

snmpoutput=`snmpget -v1 -c $snmpcommunity $upsip upsAdvBatteryRunTimeRemaining.0`

echo "runtime.value `getOIDvalue $snmpoutput`"
