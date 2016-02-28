. ./MainFuntions.sh



#################### Main menu function  #######################


MainMenuOptions()
{
	if [ "$choice" = "Create" ]; then
			exist_and_create
	elif [ "$choice" = "Update" ]; then
			# Update Database function
			Table
		
	elif [ "$choice" = "Delete" ]; then
			Delete

	elif [ "$choice" = "Display" ]; then
		    Display
	
	elif [ "$choice" = "User" ]; then
			CreateNewUser 

	elif [ "$choice" = "Logout" ]; then
		    sleep 3 | zenity --progress --no-cancel --title="Exit" --width=100  --height=100  --text="Logging out"  --pulsate --auto-close 
			Login # Logout 
	elif [ "$choice" = "Exit" ]; then
			sleep 3 | zenity --progress --no-cancel --title="Exit" --width=100  --height=100  --text="Thank you for using ANonSec DBMS"  --pulsate --auto-close 
		    exit
	fi
}


mainmenu()
{
			# 0 for root , 1 for Admin , 2 for viewer 

		if [[ $usertype -eq 0 ]]; then
				
			choice=`zenity --list \
 				 --title="MAIN MENU" \
 				 --text="Welcome $frmuname - your ID is : <b> $userID </b> , Choose what would you like to do " \
			     --column="Operation " --column="Description" \
		         Create "Create New database for user $frmuname" \
 	   		     Update "create tables | Modify columns and rows " \
 		 	     Delete "Delete database" \
 		 	     Display "Display Databases | Display Table " \
   		         User "Create new user | For administrators only " \
   		         Logout "Logging out of system" \
   		         Exit " Close the program " \
   		         --width=400 --height=400` MainMenuOptions ;


 	 	elif [[ $usertype -eq 1 ]]; then
				
			choice=`zenity --list \
 				 --title="MAIN MENU" \
 				 --text="Welcome $frmuname , Choose what would you like to do " \
			     --column="Operation " --column="Description" \
		         Create "Create New database for user $frmuname" \
 	   		     Update "create tables | Modify columns and rows " \
 	   		     Delete "Delete database" \
   		         Display "Display Databases | Display Table " \
   		         Logout "Logging out of system" \
   		         Exit " Close the program " \
 	 	         --width=400 --height=400`  MainMenuOptions ; 


 	    else 				
			choice=`zenity --list \
 				 --title="MAIN MENU" \
 				 --text="Welcome $frmuname , Choose what would you like to do " \
			     --column="Operation " --column="Description" \
		          Display "Display Databases | Display Table " \
		          Logout "Logging out of system" \
		          Exit " Close the program " \
 	 	         --width=400 --height=400` MainMenuOptions ;

		fi
}



 CheckAuthentication() 
   {
		Number=1;
		while [ $Number -lt 6 ] ;  # userID:userName:userPassword:userType:userStatus
	do  
	 ExtractUserData ()
	 { 
	 	UserInfo=`grep $frmuname users.txt | cut -f$Number -d:`
	 }

		ExtractUserData # Calling function
		if   [[ $Number -eq 1 ]] ; then  username=$UserInfo 
		elif [[ $Number -eq 2  ]]; then	 userpasswd=$UserInfo
		elif [[ $Number -eq 3  ]]; then	 usertype=$UserInfo
		elif [[ $Number -eq 4  ]]; then	 userstatus=$UserInfo 
		elif [[ $Number -eq 5  ]]; then	 userID=$UserInfo 
		else
			break 
		fi

		let Number=$Number+1 ;
		done
   }


 			################### LOGIN FUNCTION ##################

Login()
{

	frmdata=$(yad --title "Login" --form --text="Welcome to ANonSec DBMS" --field "username" --field="Password:H"  --width=600)
	frmuname=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $1 }')
	frmupass=$(echo $frmdata | awk 'BEGIN {FS="|" } { print $2 }')

 	if [ $"frmuname" = "" -o "$frmupass" = "" ]; then
			exit
	else

	CheckAuthentication # call authentication method 

		   if [ "$frmuname" = "$username" -a  "$frmupass" = "$userpasswd" ] ; then # Check for user name and password 

				if [[  $userstatus -eq 1  ]]; then #check for account type 

					
							zenity --warning --text="Welcome $username , You've Logged in successfully "
							echo $frmuname >> logs/Successlog.txt 
							echo -n `date` >> logs/Successlog.txt 
							echo -e >> logs/Successlog.txt
							echo -e >> logs/Successlog.txt
							mainmenu #calling main menu disply function 
						
		   		else
				   		    zenity --warning --text="Your account has been locked , please back to your system administrator"
				            Login ; #recall login function

		        fi
			
           else

				zenity --warning --text="wrong"
				echo $frmuname >> logs/Failurelog.txt
				echo $frmupass >> logs/Failurelog.txt
   				echo -e  >> logs/Failurelog.txt
				Login ;  #calling login function 
   		   
   		   fi

	fi

}  



############################################ Delete main Function  ##########################


Delete()
{


	choice4=$(zenity --list \
 				 --title="Delete Menu" \
 				 --text="Delete .. Database ... Table ... users" \
			     --column="Operation " --column="Description" \
		           Database "delete specific databases" \
		           Table "delete specific table" \
		           User " delete specific user " \
		           Back " back to main menu" \
 	 	         --width=350 --height=350)


 	 	         if [ "$choice4" = "Database" ]; then 
              
            	    DeleteDatabase
              
         		 elif [ "$choice4" = "Table" ] ; then
              
          		    DeleteTable

         		 elif [ "$choice4" = "User" ] ; then

         		 	DeleteTable

          		  else  
         		   mainmenu
            
          fi
}

############################################ Table main Function  ##########################

Table()
{

          choice2=`zenity --list \
         --column="Operation " --column="Description" \
         Create "Create Table" \
         Insert "Insert data to table " \
         Modify "Insert data to table " \
         Back " Back to main menu" \
         --width=750`

          if [ "$choice2" = "Create" ]; then 
              
              CreateTable
              
          elif [ "$choice2" = "Insert" ] ; then
              
              InsertData

          elif [ "$choice2" = "Modify" ] ; then

            exit

          else  
            mainmenu
            
          fi
}

############################################ Diaply main Function  ##########################


Display()
{


	choice5=$(zenity --list \
 				 --title="Disply Menu" \
 				 --text="Display .. Database ... Table ... users" \
			     --column="Operation " --column="Description" \
		           Database "display specific databases" \
		           Table "display specific table" \
		           User " display specific user " \
		           Back " back to main menu" \
 	 	         --width=750 --height=750)


 	 	         if [ "$choice5" = "Database" ]; then 
              
            	   DisplayDatabase
              
         		 elif [ "$choice5" = "Table" ] ; then
              
          		    DisplyTable

         		 elif [ "$choice5" = "User" ] ; then

         		 	DisplayeUser

          		  else  
         		   mainmenu
            
          fi
}