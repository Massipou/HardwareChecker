upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "energy-full-design|energy-full|capacity|percentage" | sed 's/ *//g' | sed 's/:/=/g' > logs/battery/battery
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "energy-full-design|energy-full|capacity"
capacity=$(cat logs/battery/battery|grep capacity | sed 's/capacity=//' | sed 's/%//' | sed 's/,.*//')
if [ $capacity -ge 70 ]
then
        echo "Capacity OK"
        ./chg_status.sh battery OK

else
        echo 'Capacité de la battery inferieure à 70% !'
        ./chg_status.sh battery error
fi
