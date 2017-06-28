#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

#Check Root
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }
. ./config.mcmgr
echo "Welcome to Minecraft Server Manager"

echo 'Author:Kirito'
echo "Enter numbers to select function:"
echo ""
echo "1.Run this server"
echo "2.Go back to the console"
echo "3.Force stop this server"
echo "4.Read config"
while :; do echo
	read -p "Please Select： " choice
	if [[ ! $choice =~ ^[1-4]$ ]]; then
		echo "Error select!"
	else
		break	
	fi
done

if [[ $choice == 1 ]];then
	screen -dmS minecraft java $javapre -Xmx$rammax -Xms$ramlimit -jar $mcdir -nogui
fi

if [[ $choice == 2 ]];then
	screen -R minecraft
fi

if [[ $choice == 3 ]];then
	mcpid=$(ps -ef|grep 'minecraft' |grep -v grep |awk '{print $2}')
	kill -9 $mcpid
	screen -wipe
fi

if [[ $choice == 4 ]];then
	cat server.properties
fi
