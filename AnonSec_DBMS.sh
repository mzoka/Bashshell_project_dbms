# Welcome to AnonSec Database managment system 
# This program is written by Mahmoud Mohammed & Ziad said Cyber Security - ITI - Nozha36 
# Used technologies : SublimText Editor , Bash shell script , Coded on kali Linux 2016 
#!/bin/bash
#ffff
username='admin'
password='admin'


frmdata=$(yad --title "Login" --form --field "username" --field="Password")
frmuname=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $1 }')
frmupass=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $2 }')

if [ "$frmuname" = "ziad" -a  "$frmupass" = "123" ] ; then

zenity --warning --text="Logged in successfully"
	echo $frmuname >> logs/Successlog.txt
	echo $frmupass >> logs/Successlog.txt

else

zenity --warning --text="wrong"
	echo $frmuname >> logs/Failurelog.txt
	echo $frmupass >> logs/Failurelog.txt
fi


