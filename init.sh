#!/bin/bash
#echo -e "disk=none\nwifi=none\nbluetooth=none\naudio=none\nbattery=none" > logs/health
#sudo chown www-data:user darkpan/checkinglist

echo -e "var Heath = \n{\n    sn : \"\",\n    disk : \"\",\n    wifi : \"\",\n    bluetooth : \"\",\n    audio : \"\",\n    CPU_FAN: \"\",\n    battery : \"\"\n};" > darkpan/logs/health.js
echo "" > logs/inventory
echo "" > darkpan/logs/inventory.html
echo "" > darkpan/logs/disk.html
echo "" > darkpan/logs/wifi.html
echo "" > darkpan/logs/bluetooth.html
echo "" > checkinglist

rm  logs/audiologs/*
rm logs/battery/*
rm logs/bluetooth/*
rm logs/disk/disklog/*
rm logs/fanlogs/*
rm logs/inventory
rm logs/wifilogs/*


if [ "$1" = "live" ]
then
	echo "islive=true" > islive.cfg
	sudo chown -R :user *
	sudo chown -R user:user logs/
	sudo chown -R www-data:user darkpan/
else
	echo "islive=false" > islive.cfg
fi

sudo chmod g+w darkpan/checkinglist
