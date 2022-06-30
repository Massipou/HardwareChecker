pulseaudio -k
/bin/alsabat -F448:1400 --file=asset/audiotest.wav -k20 2> logs/audiologs/audio
echo "$!"
if [ "$(cat logs/audiologs/audio | grep "FAIL: Peak freq too high")" = "" ]; then
	echo "failed :("
	./chg_status.sh audio error
else
	echo "success :) "
	./chg_status.sh audio OK
fi
