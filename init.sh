#!/bin/bash
#echo -e "disk=none\nwifi=none\nbluetooth=none\naudio=none\nbattery=none" > logs/health
#sudo chown www-data:user darkpan/checkinglist
user="helton"

echo -e "var Heath = \n{\n    sn : \"\",\n    disk : \"\",\n    wifi : \"\",\n    bluetooth : \"\",\n    audio : \"\",\n    CPU_FAN: \"\",\n    battery : \"\"\n};" > darkpan/logs/health.js
echo "" > logs/inventory
echo "" > darkpan/logs/inventory.html
echo "" > darkpan/logs/disk.html
echo "" > darkpan/logs/wifi.html
echo "" > darkpan/logs/bluetooth.html
echo "" > darkpan/logs/fan.html
echo "" > checkinglist

echo "" >  logs/audiologs/audio
echo "" > logs/battery/battery
echo "" > logs/bluetooth/battery
echo "" > logs/disklog/log_sda
echo "" > logs/fanlogs/fanlogs
echo "" > logs/inventory
echo "" > logs/wifilogs/wifiresult

if [ "$1" = "live" ]
then
	echo "islive=true" > islive.cfg
	sudo chown -R :user *
	sudo chown -R user:user logs/
	sudo chown -R www-data:user darkpan/
else
	echo "islive=false" > islive.cfg
	sudo chown -R $user:$user logs/
	sudo chown -R $user:www-data darkpan/
fi

sudo chmod g+w checkinglist
sudo chmod g+w darkpan/checkinglist
sudo chmod -R g+w darkpan/logs
