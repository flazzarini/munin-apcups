#!/bin/bash

# Enviroment config variables needed
## [apcups_*]
## env.snmpcommunity foo
## env.upsip $ip (or hostname, however you access your UP)

function getOIDvalue {
    localoutput=`echo $* | sed 's/.*: \(.*\)$/\1/' `
    echo "scale=1; $localoutput/10" | bc
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Load"
    echo "graph_vlabel Load Percentage (%)"
    echo "graph_category power"
    echo "runtime.label Load"
    echo "graph_args --upper-limit 100"
    echo "graph_info Load of Power Protected Machines on UPS"
    exit 0
fi

snmpoutput=`snmpget -v1 -c $snmpcommunity $upsip upsHighPrecOutputLoad.0`

echo "runtime.value `getOIDvalue $snmpoutput`"
