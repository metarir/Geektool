#!/bin/sh

localcount=$(df -hl | egrep -v '(devfs|fdesc)' | wc -l)

echo "Local filesystems:\n"

for ((i=2;i<=$localcount;i++))
do
	mountpoint=$(df -Hl | egrep -v '(devfs|fdesc)' | sed -n "$i"p | awk '{print $9}')
	label=$(diskutil list -plist $mountpoint | grep -A1 VolumeName | grep string | cut -f 2 -d \> | sed 's/<.string//')
	data=$(df -Hl | egrep -v '(devfs|fdesc)' | sed -n "$i"p | awk '{print $4"/"$2" free - ("$5" used)"}')
	echo $label": "$data
done
echo

remotecount=$(df -H | egrep -v '(devfs|fdesc|/dev/disk|map)' | wc -l)

if [ $remotecount -ge 2 ] 
then
    echo "Remote filesystems:\n"
	for ((j=2;j<=$remotecount;j++))
	do
		echo $(df -H | egrep -v '(devfs|fdesc|/dev/disk|map)' | sed -n "$j"p | awk '{print $1" :"$4"/"$2" free - ("$5" used)"}')
	done
fi