#echo -e "disk=none\nwifi=none\nbluetooth=none\naudio=none\nbattery=none" > logs/health
echo -e "var Heath = \n{\n    SN : \"\",\n    disk : \"\",\n    wifi : \"\",\n    bluetooth : \"\",\n    audio : \"\",\n    CPU_FAN: \"\",\n    battery : \"\"\n};" > darkpan/logs/health.js
echo "" > logs/inventory
echo "" > darkpan/logs/inventory.html
echo "" > checkinglist
