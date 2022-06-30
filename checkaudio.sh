pulseaudio -k
/bin/alsabat -F448:1400 --file=asset/audiotest.wav -k20 2> logs/audiologs/audio
echo "$!"
if [ "$(cat logs/audiologs/audio | grep "FAIL: Peak freq too high")" = "" ]; then
	echo "failed :("
	echo -e "\nEchec de lecture du son. peut être que le son est trop bas ou que la carte son n'est pas detectee." >> logs/audiologs/audio
	./chg_status.sh audio error
else
	echo "success :) "
	./chg_status.sh audio OK
	echo -e "\n son entendu !\nTest réussi " >> logs/audiologs/audio
fi

sed 's/$/<br>/' logs/audiologs/audio > darkpan/logs/audio.html
