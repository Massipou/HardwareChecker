#!/bin/bash
lines=$(cat logs/disklog/disks)
for disk in $lines
do
	echo -e "\nQUICK CHEK DISK ON $disk \n"

	smart_support=$(sudo smartctl -i /dev/$disk | grep "SMART support is" | tail -1 | sed 's/SMART support is: //')
	if [ "$smart_support" == "Enabled" ]
	then
		echo "smart support is enabled !"
		echo "launching tests ..."
		sudo smartctl -t short /dev/$disk
	else
		echo "/!\ smart support is disabled on $disk ! Can't chack disks."
	fi
done
echo -e "\n Please Wait 2 minutes ..."
./timer.sh 130
sleep 2
for disk in $lines
do
	sudo smartctl -q errorsonly -H -l selftest /dev/$disk > logs/disklog/log_$disk.txt
	if [ "$(sudo smartctl -q errorsonly -H -l selftest /dev/sda)" == "" ]
	then
		echo "pas d'erreur sur $disk"
		./chg_status.sh disk OK
	else
		echo -e "\nerreur sur $disk \n"
		cat logs/disklog/log_$disk.txt
		./chg_status.sh disk error
	fi
done
