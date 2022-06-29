#!/bin/bash
AUTO="true"
#echo -e "disk=none\nwifi=none\nbluetooth=none\naudio=none\nbattery=none" > logs/health
echo -e "var Heath = \n{\n    disk : \"\",\n    wifi : \"\",\n    bluetooth : \"\",\n    audio : \"\",\n    CPU_FAN: \"\",\n    battery : \"\"\n};" > darkpan/logs/health.js

wait () {
	if [ $AUTO = "false" ]; then
		read -p "Press enter to continue"
	fi
}

cat darkpan/checkinglist | sed 's/\s/\n/g' | sed 's/\n//g' > checkinglist

componentlist=$(cat checkinglist)

echo '\\\\\\\\PC tester////////>'

echo "  INVENTORY :"
wait
echo
sudo ./inventory.sh
echo "Press enter to continue"
wait

for cpn in $componentlist
do

	if [ $cpn == "disk" ]
	then
		echo "	CHECK DISK:"
		wait
		sudo ./checkdisk.sh
		echo
		wait
	fi

	if [ $cpn == "audio" ]
	then
		echo -e "	AUDIO \n Attention baisser le son ! \n cela peut piquer les oreilles :"
		wait
		echo
		./checkaudio.sh
		wait
	fi

	if [ $cpn == "wifi" ]
	then
		echo
		echo "  CHECK WIFI:"
		wait
		echo
		sudo ./checkwifi.sh
		echo
		wait
	fi

	if [ $cpn == "bluetooth" ]
	then
		echo
		echo "  CHECK BLUETOOTH:"
		wait
		echo
		sudo ./checkbluetooth.sh
		echo
		wait
	fi

	if [ $cpn == "battery" ]
	then
		echo
		echo "  CHECK BATTERY:"
		wait
		sudo ./checkbattery.sh
	fi

	if [ $cpn == "fan" ]
	then
		echo
		echo "	CHECK PROCESSOR FAN"
		/fantester/fantester.sh
		wait

done
