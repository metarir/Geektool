#!/bin/sh

cpuload=$(top -l1 -n0 | awk '/CPU/')
mem=$(top -l1 -n0 | awk '/PhysMem/')

echo CPU:
echo $cpuload | awk '{print "Benutzer: \t\t " $3}'
echo $cpuload | awk '{print "System: \t\t\t " $5}'
echo $cpuload | awk '{print "Frei: \t\t\t " $7}'
echo
echo RAM:
echo $mem | awk '{print "Aktiv: \t\t\t " $2+0 " MB"}'
echo $mem | awk '{print "Frei: \t\t\t " $6+0 " MB"}'