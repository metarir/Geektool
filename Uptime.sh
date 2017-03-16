#!/bin/sh

einheit=$(uptime | awk '{print $4 }' | sed 's/,//' | sed 's/s//')
subeinheit=$(uptime | awk '{print $6 }' | sed 's/,//' | sed 's/s//')
ok=false

case "$einheit" in
	"ecs") ausgabe=$(uptime | awk '{print $3+0 " " $4}' | sed 's/secs,/Sekunden/');ok=true;;
	"min" ) ausgabe=$(uptime | awk '{print $3+0 " " $4}' | sed 's/mins,/Minuten/' | sed 's/min,/Minute/');ok=true;;
	"hr") ausgabe=$(uptime | awk '{print $3+0 " " $4}' | sed 's/hrs,/Stunden/' | sed 's/hr,/Stunde/');ok=true;;
esac
if [ "$ok" = "false" ]
then
	if [ "$einheit" = "day" ] || [ "$einheit" = "days" ]
	then
		if [ "$subeinheit" = "ecs" ]
		then
			ausgabe=$(uptime | awk '{print $3 " " $4 " " $5 }' | sed 's/days,/Tage/' | sed 's/day,/Tag/')" Sekunden"
		elif [ "$subeinheit" = "min" ]
		then
			ausgabe=$(uptime | awk '{print $3 " " $4 " " $5 }' | sed 's/days,/Tage/' | sed 's/day,/Tag/')" min"
		else
			ausgabe=$(uptime | awk '{print $3 " " $4 " " $5 }' | sed 's/days,/Tage/' | sed 's/day,/Tag/' | sed 's/:/h /' | sed 's/,/min/')
		fi
	else
	 ausgabe=$(uptime | awk '{print $3 }' | sed 's/:/h /' | sed 's/,/min/')
	fi
fi

echo "Uptime: \t\t\t $ausgabe"