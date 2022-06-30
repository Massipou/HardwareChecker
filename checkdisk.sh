#!/bin/bash
lines=$(cat logs/disklog/disks | sed '/^[[:space:]]*$/d')
for disk in $lines
do
	echo -e "\nQUICK CHEK DISK ON $disk \n"
	echo -e "\nQUICK CHEK DISK ON $disk \n" > logs/disklog/log_$disk.txt

	smart_support=$(sudo smartctl -i /dev/$disk | grep "SMART support is" | tail -1 | sed 's/SMART support is: //')
	if [ "$smart_support" == "Enabled" ]
	then
		echo "smart support is enabled !"
		echo "launching tests ..."
		sudo smartctl -t short /dev/$disk
	else
		echo "/!\ smart support is disabled on $disk ! Can't check disks."
		echo "/!\ smart support is disabled on $disk ! Can't check disks." >> logs/disklog/log_$disk.txt
	fi
done
echo -e "\n Please Wait 2 minutes ..."
./timer.sh 1
sleep 2
echo "" > darkpan/logs/disk.html
for disk in $lines
do
#	echo -e "Report for $disk" >> logs/disklog/log_$disk.txt
	sudo smartctl -q errorsonly -H -l selftest /dev/$disk > temp
	disklog=$(cat temp)
	if [ "$disklog" == "" ]
	then
		echo "pas d'erreur sur $disk"
		./chg_status.sh disk OK
		echo "No errors detected on $disk" >> logs/disklog/log_$disk.txt
	else
		echo -e "\nerreur sur $disk \n"
		cat temp
		cat temp >> logs/disklog/log_$disk.txt
		./chg_status.sh disk error
	fi
	
	sed 's/$/<br>/' logs/disklog/log_$disk.txt >> darkpan/logs/disk.html
done
rm temp
