#echo -e "disk=none\nwifi=none\nbluetooth=none\naudio=none\nbattery=none" > logs/health
sudo chown www-data:www-data darkpan/checkinglist
echo -e "var Heath = \n{\n    sn : \"\",\n    disk : \"\",\n    wifi : \"\",\n    bluetooth : \"\",\n    audio : \"\",\n    CPU_FAN: \"\",\n    battery : \"\"\n};" > darkpan/logs/health.js
echo "" > logs/inventory
echo "" > darkpan/logs/inventory.html
echo "" > darkpan/logs/disk.html
echo "" > darkpan/logs/wifi.html
echo "" > darkpan/logs/bluetooth.html
echo "" > checkinglist
if [ "$1" == "live" ]
then
	echo "islive=true" > islive.cfg
else
	echo "islive=false" > islive.cfg
fi
