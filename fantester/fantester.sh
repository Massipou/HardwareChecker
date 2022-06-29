#!/bin/bash
start="true"
fantester/fantester &
while [ "$start" == "true" ]
do
	cputemp=$(sensors| grep 'CPU' | sed -E 's/\s|CPU:|s|C|°|\..*//g'| sed 's/+//')	# degrees
	fanspeed=$(sensors| grep 'Processor Fan' |sed -E 's/Processor Fan:|RPM|\s//g')	# RPM
	echo "CPU temperature: $cputemp °C / CPU Fan Speed: $fanspeed RPM" > logs/fanlogs/fanlogs
	cat logs/fanlogs/fanlogs

	if [ $fanspeed -ge 300 ]
	then
		echo "Fan is working "
		./chg_status.sh CPU_FAN OK
		start="false"
	elif [ $cputemp -ge 68 ]
	then
		echo "Les ventilateurs ne tournent pas alors que la temperature du processeur est >= 68°C Le ventilateur est sois pas assez puissant, soit il ne fonctionne pas, soit le system est incapable de trouver le capteur" >> logs/fanlogs/fanlogs
		cat logs/fanlogs/fanlogs
		./chg_status.sh CPU_FAN error
		start="false"
	fi
	sleep 1
done
killall fantester
