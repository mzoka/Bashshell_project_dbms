
							CreateUser() #function for create user by Admin
{
 
Form1=$(zenity --forms --title='Create New User' --text='Enter information about new user' --add-entry='username' --add-password='Password')
New_Name=$(echo $Form1 | awk 'BEGIN {FS="|" } { print $1 }')  
New_Pass=$(echo $Form1 | awk 'BEGIN {FS="|" } { print $2 }') 

Form2=`zenity --list --text "Select user type" --radiolist --column "#" --column "user type" TRUE root FALSE admin FALSE viewer`

if   [ $Form2 = "root" ]; then
	New_type="0"

elif [ $Form2 == "admin" ]; then
	New_type="1"

elif [ $Form2 == "viewer" ]; then
	New_type="2" 

else 
	mainmenu ;
fi

Form3=`zenity --list --text "Select user status" --radiolist --column "#" --column "Locked/Unlocked" TRUE Locked FALSE Unlocked --width=600`

if [ $Form3 = "Locked" ]; then
	New_status="0"
elif [ $Form3 = "Unlocked" ]; then
	New_status="1"
else
	mainmenu ; # Never Exist 
fi

let New_ID=Last_ID+1

echo "$New_Name:$New_Pass:$New_Type:$New_Status:$New_ID" >> users.txt
zenity --info
mainmenu

}

# New User Data -- New_Name     New_Pass     New_Type    New_Status    New_ID

########################################################################################




#################### Main menu function  #######################


MainMenuOptions()
{
	if [ $choice = "Create" ]; then
			echo "Create"
	elif [ $choice = "Update" ]; then
			# Delete Database function
			echo "Update"
	elif [ $choice = "Delete" ]; then
			# Delete Database function
			echo "Delete"
	elif [ $choice = "Display" ]; then
		    # Display Database information
		    echo "Display"
	elif [ $choice = "User" ]; then
			CreateUser # create user managment function
	elif [ $choice = "Exit" ]; then
		    # Exit Function 
		    echo " anything" ;

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
   		         Exit " Close the program " \
   		         --width=750` MainMenuOptions ;


 	 	elif [[ $usertype -eq 1 ]]; then
				
			choice=`zenity --list \
 				 --title="MAIN MENU" \
 				 --text="Welcome $frmuname , Choose what would you like to do " \
			     --column="Operation " --column="Description" \
		         Create "Create New database for user $frmuname" \
 	   		     Update "create tables | Modify columns and rows " \
 	   		     Delete "Delete database" \
   		         Display "Display Databases | Display Table " \
   		         Exit " Close the program " \
 	 	         --width=750`  MainMenuOptions ; 


 	    else 				
			choice=`zenity --list \
 				 --title="MAIN MENU" \
 				 --text="Welcome $frmuname , Choose what would you like to do " \
			     --column="Operation " --column="Description" \
		          Display "Display Databases | Display Table " \
		          Exit " Close the program " \
 	 	         --width=750` MainMenuOptions ;

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
}  
