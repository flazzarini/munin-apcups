#!/bin/bash

# Enviroment config variables needed
## [apcups_batterytemp]
## env.snmpcommunity foo
## env.upsip $ip (or hostname, however you access your UP)

# snmpget -v1 -c upspublic 10.10.0.15 upsAdvBatteryTemperature.0 | sed 's/.*: \(.*\)$/\1/'

function getOIDvalue {
    echo $* | sed 's/.*: \(.*\)$/\1/'
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Battery Temperature"
    echo "graph_vlabel Celsius"
    echo "graph_args --upper-limit 100"
    echo "graph_category power"
    echo "temp.label Temperature"
    echo "graph_info Battery Temperature in Celsius"
    exit 0
fi

snmpoutput=`snmpget -v1 -c $snmpcommunity $upsip upsAdvBatteryTemperature.0`

echo "temp.value `getOIDvalue $snmpoutput`"
