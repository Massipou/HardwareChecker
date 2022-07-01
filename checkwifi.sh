touch logs/wifilogs/wifiresult
nmcli dev wifi list > logs/wifilogs/wifiresult
wifi_count=$(wc -l < logs/wifilogs/wifiresult)
echo "wifiresult: $wifiresult"
if [ $wifi_count -gt 1 ]
then
	echo "wifi is working"
	./chg_status.sh wifi OK
else
	echo "/!\wifi doesn't work"
	./chg_status.sh wifi error
fi
sed 's/$/<br>/' logs/wifilogs/wifiresult > darkpan/logs/wifi.html
