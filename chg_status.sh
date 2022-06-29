device=$1
status=$2
if [ $device != "battery" ]
then
	sed -i "s/$device.*/$device : \"$status\",/" darkpan/logs/health.js
else
	sed -i "s/$device.*/$device : \"$status\"/" darkpan/logs/health.js
fi
