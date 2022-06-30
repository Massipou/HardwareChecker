#!/bin/bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "energy-full-design|energy-full|capacity|percentage" | sed 's/ *//g' | sed 's/:/=/g' > logs/battery/battery
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "energy-full-design|energy-full|capacity"
capacity=$(cat logs/battery/battery|grep capacity | sed 's/capacity=//' | sed 's/%//' | sed 's/,.*//')
if [ $capacity -ge 60 ]
then
        echo "Capacity OK"
        ./chg_status.sh battery OK
	echo -e "\nBattery state OK" >> logs/battery/battery

else
        echo 'Capacité de la battery inferieure à 60% !'
        ./chg_status.sh battery error
	echo -e "\nBattery state <= 60%" >> logs/battery/battery
fi

sed 's/$/<br>/' logs/battery/battery > darkpan/logs/battery.html
