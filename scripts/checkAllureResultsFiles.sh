#!/bin/bash

if [ "$CHECK_RESULTS_EVERY_SECONDS" == "NONE" ] || [ "$CHECK_RESULTS_EVERY_SECONDS" == "none" ]; then
	echo "Not checking results automatically"
	while true ; do continue ; done
fi

if echo $CHECK_RESULTS_EVERY_SECONDS | egrep -q '^[0-9]+$'; then
	echo "Overriding configuration"
	SECONDS_TO_WAIT=$CHECK_RESULTS_EVERY_SECONDS
else
	echo "Configuration by default"
	SECONDS_TO_WAIT=1
	TIMEZONE=Australia/Sydney
fi

echo "Checking Test Results every $SECONDS_TO_WAIT second(s)"

while :
do
	FILES="$(echo $(ls $RESULTS_DIRECTORY -l --time-style=full-iso) | md5sum)"
	if [ "$FILES" != "$PREV_FILES" ]; then
		export env PREV_FILES=$FILES
		echo $(TZ=$TIMEZONE date) " New Test Results detected"
		/app/generateAllureReport.sh
	fi
	sleep $SECONDS_TO_WAIT
done