#!/bin/bash
hardware_inventoy () {
	echo "" > temp
	echo "Identity:"
	#sudo dmidecode -t1 |grep "Manufacturer:"|sed 's/\tManufacturer: //g'
	sudo dmidecode -t1 |grep "Manufacturer:"
	#sudo dmidecode -t1 |grep "Product Name:"|sed 's/\tProduct Name: //g'
	sudo dmidecode -t1 |grep "Product Name:"
	sn=$(sudo dmidecode -t1 |grep "Serial Number"|sed 's/\tSerial Number: //g')
	./chg_status.sh sn $sn
	sudo dmidecode -t1 |grep "Serial Number"
	echo
	echo 'Processor infos:'
	grep -m 1 'model name' /proc/cpuinfo
	echo

	echo 'Memory Infos:'
	memtotal=$(cat /proc/meminfo | grep MemTotal | sed 's/MemTotal://;s/ kB//')
	gmemtotal=$((memtotal / 1000000))
	echo "Total memory: $gmemtotal Gb"
	memory_slots=$(sudo dmidecode -t 17 | grep -o 'Memory Device' | wc -l)
	echo "Number of slots : $memory_slots"
	echo
	for ((i=1;i<=$memory_slots;i++))
	do
		echo "Memory $i"
		sudo dmidecode -t 17 |grep -m $i "Size" | tail -n1
		sudo dmidecode -t 17 |grep -m $i "Type:" | tail -n1
		sudo dmidecode -t 17 |grep -m $(($i*2-1)) "Speed" | tail -n1
		sudo dmidecode -t 17 |grep -m $(($i*2-1)) "Locator" | tail -n1
		echo

	done
	echo
	echo "Disks Infos :"
	while IFS= read -r -d $'\0' device; do
		device=${device/\/dev\//}
		disk+=($device)
		name+=("`cat "/sys/class/block/$device/device/model"`")
		size+=("`cat "/sys/class/block/$device/size"`")
	done < <(find "/dev/" -regex '/dev/sd[a-z]\|/dev/vd[a-z]\|/dev/hd[a-z]\|/dev/nvme[0-9]n[1-9]' -print0)

	for i in `seq 0 $((${#disk[@]}-1))`; do
        	bsize=${size[$i]}
        	gsize=$((bsize / 2000000))
		echo -e "${disk[$i]}\t${name[$i]}\t${gsize}Gb"
		echo -e "${disk[$i]}" >> temp
	done

	tail -n +2 temp > logs/disklog/disks
	rm temp

	echo
	echo "GPU infos"
	echo$(sudo lshw -quiet -C display |grep "produit")

}
hardware_inventoy > logs/inventory
sed 's/$/<br>/' logs/inventory > darkpan/logs/inventory.html
cat logs/inventory
