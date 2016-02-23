exist_and_create()
{ 
ID=$(tail -1 Databases/metadata 2>/dev/null|cut -f2 -d:)
if [[  -z $ID ]]; then
  ID=0
fi
texistDefultDB=$(find . -name Databases 2>/dev/null) 
sleep 3 | zenity --progress --no-cancel --title="Databases" --width=300  --height=200  --text="Searching for Databases"  --pulsate --auto-close 

if [ -z  "$texistDefultDB" ]
 then {
  mkdir Databases
  touch "Databases/metadata"
  echo "Databases:base" >>"Databases/metadata"
  #echo "database created"
  zenity --info --text="database created"
  exist_and_create $@
}
else
{


file=$(zenity --title="database" --entry --text="Enter database name" --entry-text="")
f=1 
databaseFind=$(find .  -name $file 2>/dev/null | grep  ^./Databases/$file |cut -f3 -d'/')

sleep 2 |zenity --progress --no-cancel  --title="Databases" --width=300  --height=200  --text="Searching for database name"  --pulsate --auto-close 
if [ -z "$databaseFind" ] && [ -n "$file" ]
then  
{  
let 'ID++'
  f=0
  mkdir "Databases/$file">/dev/null
  database=$(find .  -name $file 2>/dev/null | grep  ^./Databases/$file |cut -f3 -d'/') 
  echo -e  "$database:$ID:" >> "Databases/metadata"
  #echo "$file has been created :)"
  zenity --info --text="$file has been created"
  exist_and_create $@

}
fi

if [  $f != 0  ] 
 then  
{
  let 'ID++'
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
  		echo -e "$newDatabase:$ID:" >> "Databases/metadata"
  		dcount=1
  		# echo "created with name $newDatabase '$_$'"
       zenity --info --text="created with name $newDatabase $_$"
  	fi
  	done
  fi
} 
fi
}
fi
}

exist_and_create $@ 2>/dev/null

