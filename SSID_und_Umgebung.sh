#!/bin/sh

netz=$(networksetup -getairportnetwork en1 | cut -f2 -d: | sed 's/^[ \t]*//')

checkairport=$(echo $netz | awk '{print $3 $4}')
if [ "$checkairport" = "notassociated" ]
then
 netz="N/A"
fi

umgebung=$(networksetup -getcurrentlocation | sed 's/Automatic/Automatisch/')

red="\x1b[31m"
reset="\x1b[39m"
farbe=$reset

if [ "$umgebung" != "Automatisch" ] 
then 
  farbe=$red
fi

echo "SSID:\t\t\t $netz"
echo "Umgebung:\t\t $farbe$umgebung$reset"