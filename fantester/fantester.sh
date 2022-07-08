#!/bin/bash
#cpu_number=$(lscpu | grep 'Socket(s):' | sed 's/Socket(s)://' | sed 's/ //g')
cpu_number=$(lscpu | grep 'Socket(s)' | sed 's/.*://' | sed 's/ //g')
fantester/fantester &
echo "number of CPU: $cpu_number"
echo "" > logs/fanlogs/fanlogs

#for (( i=1;i<=$cpu_number; i++ ))
echo $cpu_number
for (( i=1;i<=$cpu_number; i++ ))
do
        start="true"
        echo "testing CPU Fan $i"
        disk=$(($i-1))

        while [ "$start" == "true" ]
        do
                cputemp=$(sensors| grep 'CPU' | sed -E 's/\s|CPU:|s|C|°|\..*//g'| sed 's/+//')  # degrees
                if [ "$cputemp" = "" ]; then
                        cputemp=$(sensors | grep "Package id $disk" | sed -E "s/\s|Package id $disk:|s|C|°|\..*//g"| sed 's/+//')
			if [ "$cputemp" = "" ]; then
				echo '/!\ Can t test CPU temperature ! ' >> logs/fanlogs/fanlogs
				tail -1 logs/fanlogs/fanlogs
				./chg_status.sh CPU_FAN error
				exit
			fi
                fi
                fanspeed=$(sensors| grep 'Processor Fan' |sed -E 's/Processor Fan:|RPM|\s//g'|sed 's/(.*)//g')  # RPM
                if [ "$fanspeed" = "" ]; then
                        fanspeed=$(sensors| grep "fan$i" |sed -E "s/fan$i:|RPM|\s//g"|sed 's/(.*)//g')
			if [ "$fanspeed" = "" ]; then
                                echo '/!\ Can t test CPU FAN ! ' >> logs/fanlogs/fanlogs
                                tail -1 logs/fanlogs/fanlogs
                                ./chg_status.sh CPU_FAN error
                                exit
			fi
                fi
                echo "CPU temperature: $cputemp °C / CPU Fan Speed: $fanspeed RPM" >> logs/fanlogs/fanlogs
                tail -1 logs/fanlogs/fanlogs

                if [ $fanspeed -ge 300 ]
                then
                        echo "Fan is working "
                        ./chg_status.sh CPU_FAN OK
                        start="false"
                elif [ $cputemp -ge 68 ]
                then
                        echo "Les ventilateurs ne tournent pas alors que la temperature du processeur est >= 68°C Le ventilateur est sois pas assez puissant, soit il ne fonctionne pas, soit le system est incapable de trouver le capteur" >> logs/fanlogs/fanlogs
                        tail -1 logs/fanlogs/fanlogs
                        ./chg_status.sh CPU_FAN error
                        start="false"
                fi
                sleep 1
        done
done
killall fantester

sed 's/$/<br>/' logs/fanlogs/fanlogs > darkpan/logs/fan.html
