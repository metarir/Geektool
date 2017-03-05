#!/bin/sh

hostname=$(scutil --get ComputerName)
username=$(whoami)
mem=$(sysctl -n hw.memsize | awk '{print $0/1073741824" GB RAM"}')
cpu=$(sysctl -n machdep.cpu.brand_string)
os=$(sw_vers | grep 'ProductName' | awk '{print $2" "$3" "$4}')
osversion=$(sw_vers | grep 'ProductVersion' | awk '{print $2}')
myen0=$(ifconfig en0 | grep "inet " | awk '{print $2}')
if [ "$myen0" = "" ]
then
 myen0="N/A"
fi
myen1=$(ifconfig en1 | grep "inet " | awk '{print $2}')
if [ "$myen1" = "" ]
then
 myen1="N/A"
fi
mywan=$(dig +short myip.opendns.com @resolver1.opendns.com)
if [ "$mywan" = "" ]
then
 mywan="N/A"
fi

echo "Hostname: \t\t $hostname"
echo "Username: \t\t $username" 
echo "Memory: \t\t $mem"  
echo "CPU: \t\t\t $cpu"
echo "OS: \t\t\t\t $os $osversion" 
echo "Ethernet IP: \t\t $myen0"
echo "Wireless IP: \t\t $myen1"
echo "Internet IP: \t\t $mywan"