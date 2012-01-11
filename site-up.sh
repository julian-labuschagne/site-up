#!/bin/bash

function check_status() {
	clear
	echo "Checking site statuses ..."
	echo

	while read line
	do
		STATUS_CODE=$(curl -sL -m 5 -w "%{http_code}" "$line" -o /dev/null)
		
		if [[ $STATUS_CODE -eq "200" ]]; then
			site_status="[OK]"
			printf "%-66s \e[1;32m %10s \e[0m \n" $line $site_status
		elif [[ $STATUS_CODE -eq "403" ]]; then
			site_status="[OK]"
			printf "%-66s \e[1;33m %10s \e[0m \n" $line $site_status
		else
			site_status="[NA]"
			printf "%-66s \e[1;31m %10s \e[0m \n" $line $site_status
			beep -e /dev/input/by-path/platform-pcspkr-event-spkr -f 800.7 -r 10 -d 200 -l 400
		fi

	done < urls.txt

  echo
	echo -n "Last checked: "
	date
	echo
	echo "Done ... press Ctrl + c to exit"
	 
	sleep 10m
}

while true
do
	check_status
done
