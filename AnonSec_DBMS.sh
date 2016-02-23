# Welcome to AnonSec Database managment system 
# This program is written by Mahmoud Mohammed & Ziad said Cyber Security - ITI - Nozha36 
# Used technologies : SublimText Editor , Bash shell script , Coded on kali Linux 2016 
#!/bin/bash

#default username and password JUST FOR TESTT 
Defaultusername='admin'
Defaultuserpassword='admin'

#Main menu function 
mainmenu()
{

	zenity --notification --text="Welcome to DBMS $frmuname"
	
	zenity --list \
  --title="MAIN MENU" \
  --text="Welcome $frmuname , Choose what would you like to do " \
  --column="Operation " --column="Description" \
  Create "Create New database for user $frmuname" \
  Update "create tables | Modify columns and rows " \
  Delete "Delete database" \
  --width=600
  
}


############### login function ###################
Login()
{

frmdata=$(yad --title "Login" --form --field "username" --field="Password" --width=600)
frmuname=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $1 }')
frmupass=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $2 }')

if [ "$frmuname" = "$Defaultusername" -a  "$frmupass" = "$Defaultuserpassword" ] ; then

zenity --warning --text="Logged in successfully"
	echo $frmuname >> logs/Successlog.txt
	echo $frmupass >> logs/Successlog.txt

	mainmenu #calling main menu disply function 

else

zenity --warning --text="wrong"
	echo $frmuname >> logs/Failurelog.txt
	echo $frmupass >> logs/Failurelog.txt

	Login #calling login function 
fi

}
################# END of login Function #############


########################################## START POINT ##################################
# Calling login function 
Login


#################











