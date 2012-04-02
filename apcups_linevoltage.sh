#!/bin/bash

# This plugin requires 'bc'

# Enviroment config variables needed
## [apcups_*]
## env.snmpcommunity foo
## env.upsip $ip (or hostname, however you access your UP)

function getOIDvalue {
    localoutput=`echo $* | sed 's/.*: \(.*\)$/\1/' `
    unformatted_value=`echo $localoutput | tr -d '()' | cut -d" " -f1`
    echo "scale=1; $unformatted_value/10" | bc
}

if [[ $1 == config ]]; then
    echo "graph_title APC UPS Voltage"
    echo "graph_vlabel Volts"
    echo "graph_category power"
    echo "input_voltage.label Input Voltage from Utility"
    echo "output_voltage.label Output Voltage"
    echo "graph_info Input/Output Voltage"
    exit 0
fi

voltage_incoming_snmpget=`snmpget -v1 -c $snmpcommunity $upsip upsHighPrecInputLineVoltage.0`
voltage_outgoing_snmpget=`snmpget -v1 -c $snmpcommunity $upsip upsHighPrecOutputVoltage.0`

echo "input_voltage.value `getOIDvalue $voltage_incoming_snmpget`"
echo "output_voltage.value `getOIDvalue $voltage_outgoing_snmpget`"
