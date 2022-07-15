#!/bin/bash
echo -e "\nBluetooth tester\n"
sudo rfkill unblock all
echo "checking bluetooth service:"
./remallbluedevices.sh
isactive=$(systemctl is-active bluetooth)
if [ $isactive = active ]
then
	echo "bluetooth is actived"
else
	echo "activating bluetooth ..."
	sudo systemctl start bluetooth
	if [ "$?" == "0" ]
	then
		echo "success !"
		sleep 3
	else
		echo "fail!"
		./chg_status.sh bluetooth error
		echo "failed to activate bluetooth" > logs/bluetooth/bluedev
		exit
	fi
fi

bluetoothctl --timeout=30 scan on &
echo "checking bluetooth devices for 30 seconds"
./timer.sh 30
bluetoothctl devices > logs/bluetooth/bluedev
devices=$(cat logs/bluetooth/bluedev|grep "Device")
echo $devices
if [ "$devices"  = "" ]
then
	echo "nothing detected or controller error!"
	echo "nothing detected or controller error!" >> logs/bluetooth/bluedev
	./chg_status.sh bluetooth error
else
	echo "Device detected !"
	./chg_status.sh bluetooth OK
fi

sed 's/$/<br>/' logs/bluetooth/bluedev > darkpan/logs/bluetooth.html
