CreateNewUser() #function for create user by Admin
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
  New_type="3" 
fi

  New_status="1" #unlocked 

let New_ID=Last_ID+1

echo "$New_Name:$New_Pass:$New_type:$New_status:$New_ID" >> users.txt
zenity --info
mainmenu

}


# New User Data -- New_Name     New_Pass     New_Type    New_Status    New_ID

########################################################################################




############################## Create Database ##################################

exist_and_create()
{ 
DBID=$(tail -1 Databases/metadata 2>/dev/null|cut -f2 -d:)
if [[  -z $DBID ]]; then
  DBID=0
fi
texistDefultDB=$(find . -name Databases 2>/dev/null) 
sleep 3 | zenity --progress --no-cancel --title="Databases" --width=300  --height=200  --text="Searching for Databases"  --pulsate --auto-close 

if [ -z  "$texistDefultDB" ]
 then {
  mkdir Databases
  touch "Databases/metadata"
  touch "Databases/$file/Table_Metadata"
  #echo "database created"
  zenity --info --text="Database directory has been created "
  mainmenu

}
else
{


file=$(zenity --title="database" --entry --text="Enter database name" --entry-text="")
f=1 
databaseFind=$(find .  -name $file 2>/dev/null | grep  ^./Databases/$file |cut -f3 -d'/')
if [[ -z "$file" ]]
 then
  mainmenu
fi
sleep 2 |zenity --progress --no-cancel  --title="Databases" --width=300  --height=200  --text="Searching for database name"  --pulsate --auto-close 
if [ -z "$databaseFind" ] && [ -n "$file" ]
then  
{  
let 'DBID++'
  f=0
  mkdir "Databases/$file">/dev/null
  database=$(find .  -name $file 2>/dev/null | grep  ^./Databases/$file |cut -f3 -d'/') 
  echo -e  "$database:$DBID:$userID" >> "Databases/metadata"
  #echo "$file has been created :)"
  zenity --info --text="$file has been created"
  mainmenu
}

fi

if [  $f != 0  ] 
 then  
{
  let 'DBID++'
  # echo "the database created aready named $file ^_^" 
   zenity --warning --text="the database created aready named $file ^_^" --icon-name=Create-Database --ellipsize 
  # read -p " do you want to creat new db:)>" req
  req=$(zenity --question --text="do you want to creat new db?")
  if [[ $? -eq 1 ]]
   then
   req=$(zenity --question --text="are you sure exit?")
  fi
  
  # || [[ "$req" = "Y" ]]
  if [[ $? -eq 0 ]] 
   then
   	dcount=0
   	existd=:
  	while [[ "$dcount" == 0 ]] 
  	 do
      # read -p "database name $existd=:>" newDatabase 
    newDatabase=$(zenity --entry --text="database name $existd" --entry-text="")
  	databaseExist=$(find . -name $newDatabase 2>/dev/null|grep  ^./Databases/$newDatabase |cut -f3 -d'/')
    sleep 2 |zenity --progress --no-cancel  --title="Searching.." --width=300  --height=200  --text="Searching for database name exists"  --pulsate --auto-close 
  	count=$(echo $newDatabase |wc -c)
  	if [[ $databaseFind = $newDatabase ]] || [[ $newDatabase = $databaseExist ]]
  	then
  		existd="other than $databaseFind or $databaseExist"
  	fi
   	if [[ $count != 1 ]] && [[ $databaseFind != $newDatabase ]] && [[  $newDatabase != $databaseExist  ]] 
  	 then
  		mkdir "Databases/$newDatabase" 2>/dev/null 
  		echo -e "$newDatabase:$DBID:" >> "Databases/metadata"
  		dcount=1
  		# echo "created with name $newDatabase '$_$'"
       zenity --info --text="created with name $newDatabase "
  	fi
  	done
  fi
} 
fi
}
fi
}


########################################### Create table ###########################
CreateTable()
{
              #"TableID:TableName:DatabaseName:COL,TYPE:-----------------------"

              TMP=`cut -f1 -d: < ./Databases/metadata`
              Choosen_Database_Name=`zenity --list --text "Choose Database Name" --radiolist --column "Name" --column "Choice" FALSE $TMP --width=200`

              T_ID=`tail -1 < Databases/Table_Metadata | cut -f1 -d:` 
              let T_ID=T_ID+1

              T_Name_Form=$(yad --form --text=" Enter Table Name " --field="" --width=60 --center)
              T_Name_Value=$(echo $T_Name_Form | awk 'BEGIN {FS="|" } { print $1 }')
             
              C_Number_Form=$(yad --form --text=" Enter Number of columns  " --field="" --width=60 --center)
              C_Number_Value=$(echo $C_Number_Form | awk 'BEGIN {FS="|" } { print $1 }')
              
              
              echo -n "$T_ID:$T_Name_Value:$Choosen_Database_Name:$C_Number_Value:" >> Databases/Table_Metadata
             
           
              COUNTER=0
              while [ $COUNTER -lt $C_Number_Value ]; do
                   
                    
                    C_Name_Form=$(yad --form --text=" Enter Column Name " --field="" --width=100 --center)
                    C_Name_Value=$(echo $C_Name_Form | awk 'BEGIN {FS="|" } { print $1 }')

                    C_Type=`zenity --list --text "Choose <b> $C_Name </b> Type " --radiolist --column "Type" --column "Choice" FALSE INT FALSE STR TRUE MIXED --width=200`
                    
                    if [ $COUNTER -ne "$C_Number_Value" ]; then echo -n "$C_Name_Value,$C_Type:" >> Databases/Table_Metadata 
                    else echo -n "$C_Name_Value,$C_Type" >> Databases/Table_Metadata ; fi 
                      

                   let COUNTER=COUNTER+1 

              done
                echo "" >> Databases/Table_Metadata 
                echo "" > Databases/$Choosen_Database_Name/$T_Name_Value 

                sleep 1 | zenity --progress --no-cancel --width=300  --height=200  --text="Creating Tables"  --pulsate --auto-close 

                zenity --info
                mainmenu

}

########################################### insert data to table ###########################

InsertData()
{

  TMP1=`cut -f1 -d: < ./Databases/metadata`
  Choosen_Database_Name=`zenity --list --text "Choose Database Name" --radiolist --column "Name" --column "Choice" FALSE $TMP1 --width=400`
  
  TMP2=`grep $Choosen_Database_Name < Databases/Table_Metadata | cut -f2 -d:`
  Choosen_Table_Name=`zenity --list --text "Choose Table Name" --radiolist --column "Name" --column "Choice" FALSE $TMP2 --width=400`

  TMP3=`grep $Choosen_Table_Name Databases/Table_Metadata | cut -f4 -d:`  #number of columns

  
  COUNTER2=0
  InnerCounter=5


  while [ $COUNTER2 -lt $TMP3 ]; do
  
    Col_Name=`grep $Choosen_Table_Name < Databases/Table_Metadata | cut -f$InnerCounter -d: | cut -f1 -d,`
    Col_Type=`grep $Choosen_Table_Name < Databases/Table_Metadata | cut -f$InnerCounter -d: | cut -f2 -d,`
 

   TMP4=$(yad --form --text=" Enter your <b> $Col_Type </b> value here for <b> $Col_Name </b> " --field="" --width=400 --center)
   Value=$(echo $TMP4 | awk 'BEGIN {FS="|" } { print $1 }')

    
        if [ "$Col_Type" = "INT" ]; then
          
              while ! [[ $Value =~ ^[0-9]+$ ]] ; do
                  
                  TMP4=$(yad --form --text=" Sorry you must enter <b> Integer </b> value for <b> $Col_Name </b> " --field="" --width=400 --center)
                  Value=$(echo $TMP4 | awk 'BEGIN {FS="|" } { print $1 }')

              done

              echo -n "$Value:" >> Databases/$Choosen_Database_Name/$Choosen_Table_Name  
        

        elif [ "$Col_Type" = "STR" ]; then
          
              while ! [[ $Value =~ ^[a-z]+$ ]] ; do
                  
                  TMP4=$(yad --form --text=" Sorry you must enter <b> string </b> value for <b> $Col_Name </b> " --field="" --width=400 --center)
                  Value=$(echo $TMP4 | awk 'BEGIN {FS="|" } { print $1 }')

              done

              echo -n "$Value:" >> Databases/$Choosen_Database_Name/$Choosen_Table_Name  
        

        else
              
            echo -n "$Value:" >> Databases/$Choosen_Database_Name/$Choosen_Table_Name  
              
        fi

    
   let COUNTER2=COUNTER2+1
   let InnerCounter=InnerCounter+1

  done

   echo "" >> Databases/$Choosen_Database_Name/$Choosen_Table_Name  
   zenity --info
   mainmenu

}

############################# Deleting Functions #####################


DeleteDatabase()
{

       TMP2=`cut -f1 -d: < Databases/metadata`
    
       Deleted_Database_Name=$(zenity --list --text "Choose Database Name" --radiolist --column "Name" --column "Choice" FALSE $TMP2 --width=200)
       rm -r Databases/$Deleted_Database_Name

       sed -i "/$Deleted_Database_Name/d" Databases/metadata > Databases/.TEMP 
       rm Databases/.TEMP
     
       zenity --info --text="Database : <b> $Deleted_Database_Name  </b> has been successfully deleted"
       mainmenu
}

DeleteTable()
{
  exit

}

DeleteTable()
{

  exit
}



############################## Displaying Functions ####################

DisplayDatabase()
{

  exit
}

DisplyTable()
{

  exit
}


DisplayeUser()
{
  exit
}

######################### Modifying Functions ############################

