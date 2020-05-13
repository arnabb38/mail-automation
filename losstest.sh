#!/bin/bash

echo "Please Wait....."

echo "`date`

" > pingtest.txt

#ping test in GOOGLE.COM | spectrum-bd
#ping -c 5 mail.spectrum-bd.com >> pingtest.txt  #loss testing site
ping -c 5 www.bla.com >> pingtest.txt
#ping -c 5 www.google.com >> pingtest.txt

#packet=$(ping -c 3 192.168.1.1 | grep "packet loss" | awk -F ',' '{print $3}' | awk '{print $1}')

pack=$(cat pingtest.txt | grep "packet loss" | awk -F ',' '{print $3}' | awk '{print $1}')

echo "

--------------------------------------------------------------------------------


Packet Lost:" $pack >> pingtest.txt

#packet loss - INTEGER value separator  
loss_val=$(echo $pack | cut -d '%' -f1)

#------------------------------------------------------------------------------
#whatsapp & twilio
#start

your_auth_token=XXXXXXXXXXXXXXXXXXXXXXX

#end
#-------------------------------------------------------------------------------


if [ $loss_val -ge "30" ]
then
	echo "CODE RED!!!" #print in CLI

	#if code red occure, it'll send a mail	
	echo "`date` -- CODE RED!!!" | mail -A "/home/arnabb/Documents/script-pooooool/auto-mail-scripting-BI/pingtest.txt" -s "Ping Result" -a From:Admin\<admin@example.com\> XXXXXXXXX@gmail.com

	#-------------------------------------------------------
	curl -X POST https://api.twilio.com/2010-04-01/Accounts/ACXXXXXXXXXXXXXXXXXXXXXX/Messages.json \
	--data-urlencode "From=whatsapp:+XXXXXXXXX" \
	--data-urlencode "Body=Packet Loss: $pack" \
	--data-urlencode "To=whatsapp:+XXXXXXXXXXX" \
	-u ACXXXXXXXXXXXXXXXXXXXXXXX:$your_auth_token


elif [ $loss_val -gt "0" -a $loss_val -lt "30" ]
then
	echo "CODE YELLOW!!!" #print in CLI

else
	echo "CODE GREEN!!! EVERYTHING'S PERFECT!!!"
fi

echo "Thanks For Your Patience!!"
