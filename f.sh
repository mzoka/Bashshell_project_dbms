
# #function for create user by Admin
# Registeration()
# {

#  #view form of registeration
#  fReg=$(zenity --forms --title='Registeration' --text='Registeration'  --add-entry='FirstName' --add-entry='LastName' --add-password='Password' --width=600) 

#  Regfname=$(echo $fReg | awk 'BEGIN {FS="|" } { print $1 }') 

#  Reglname=$(echo $fReg | awk 'BEGIN {FS="|" } { print $2 }') 

#  RegPass=$(echo $fReg | awk 'BEGIN {FS="|" } { print $3 }') 

# }
# #regstration form call with $fReg
# fReg=$'zenity --forms --title="Registeration" --text="Registeration"  --add-entry="First Name" --add-entry="Last Name " --add-password="Password"'   
# #fReg=$(zenity --forms --title='Registeration' --text='Registeration'  --add-entry='FirstName' --add-entry='LastName' --add-password='Password' --width=600)

# #function to search for file exists-'-p'
# exist_and_create(){  
# file=`ls $@`
# if [ "$file" -eq ' ' -a $? -eq 2 ]
# 	then
# 	mkdir $@ 
# fi
# }
# exist_and_create(){ 
#  file=$(ls $*)
#  echo $file
# if [ "$file" = ' ' -a $? -eq 2 ]
# then 
# { 
#  echo created
#  mkdir $* 
# }
# elif [ "$file" != ' ' -a $? -eq 0  ]
# then	
# {
#  echo "the database created"
# }
# fi
# }
exist_and_create()
{ 

texistDefultDB=$(find . -name Databases) 

if [ -z  "$texistDefultDB" ]
 then {
  mkdir Databases
  touch "Databases/metadata"
  echo "Databases:base" >>"Databases/metadata"
  echo "database created"
}
else
{

file=$@
f=1 
databaseFind=$(find .  -name $file 2>/dev/null| grep  ^./Databases/$file |cut -f3 -d'/')
if [ -z "$databaseFind" ]
then  
{  
  f=0
  mkdir "Databases/$file"
  database=$(ls -R $file 2>/dev/null |grep  ^./Databases/$file |cut -f3 -d'/') 
  echo -e  "\n$database:" >> "Databases/metadata"
  echo "$file has been created :)"
}
fi

if [  $f != 0  ] 
 then  
{
  echo "the database created aready named $file ^_^" 
  read -p "you want to creat new db:)>" req
  if [[ "$req" = "y" ]] || [[ "$req" = "Y" ]]
   then
   	dcount=0
   	existd=:
  	while [[ "$dcount" == 0 ]] 
  	 do
  	read -p "database name $existd=:>" newDatabase 
  	databaseExist=$(find . -name $newDatabase 2>/dev/null|grep  ^./Databases/$newDatabase |cut -f3 -d'/')
  	count=$(echo $newDatabase |wc -c)
  	if [[ $databaseFind = $newDatabase ]] || [[ $newDatabase = $databaseExist ]]
  	then
  		existd="other than $databaseFind or $databaseExist"
  	fi
   	if [[ $count != 1 ]] && [[ $databaseFind != $newDatabase ]] && [[  $newDatabase != $databaseExist  ]] 
  	 then
  		mkdir "Databases/$newDatabase" 
  		echo -e "\n$1:" >> "Databases/metadata"
  		dcount=1
  		echo "created with name $newDatabase '$_$'"
  	fi
  	done
  fi
} 
fi
}
fi
}
exist_and_create $@










