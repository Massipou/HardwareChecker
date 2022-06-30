#!/bin/bash
. islive.cfg

echo "is live ? $islive"

if [ "$islive" == "false" ]
then
	echo 'User!123' | sudo -S echo "bonjour root"
fi

AUTO="true"

wait () {
	if [ $AUTO = "false" ]; then
		read -p "Press enter to continue"
	fi
}
whoami
cat darkpan/checkinglist | sed 's/\s/\n/g' | sed 's/\n//g' > checkinglist
echo "What have to be tested:"
echo $(cat darkpan/checkinglist)

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
		fantester/fantester.sh
		wait
	fi
done
