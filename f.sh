
#function for create user by Admin
Registeration()
{

 #view form of registeration
 fReg=$(zenity --forms --title='Registeration' --text='Registeration'  --add-entry='FirstName' --add-entry='LastName' --add-password='Password' --width=600) 

 Regfname=$(echo $fReg | awk 'BEGIN {FS="|" } { print $1 }') 

 Reglname=$(echo $fReg | awk 'BEGIN {FS="|" } { print $2 }') 

 RegPass=$(echo $fReg | awk 'BEGIN {FS="|" } { print $3 }') 

}
#regstration form call with $fReg
fReg=$'zenity --forms --title="Registeration" --text="Registeration"  --add-entry="First Name" --add-entry="Last Name " --add-password="Password"'   

#fReg=$(zenity --forms --title='Registeration' --text='Registeration'  --add-entry='FirstName' --add-entry='LastName' --add-password='Password' --width=600)

#function to search for file exists-'-p'
exist(){  file=`ls $@`;}
if [ "$file" -eq ' ' -a $? -eq 2 ]
	then
	mkdir $@ 
fi
