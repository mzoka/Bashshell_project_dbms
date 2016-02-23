# Welcome to AnonSec Database managment system 
# This program is written by Mahmoud Mohammed & Ziad said Cyber Security - ITI - Nozha36 
# Used technologies : SublimText Editor , Bash shell script , Coded on kali Linux 2016 
#!/bin/bash

. ./ExternalFunctions.sh


				# ------------ + ----------------- + Global Variables + ----------- + ----------- #

Number_of_users=`wc -l < users.txt` # Number of users 
ID=0 # First User ID 
Last_ID=`tail -1 users.txt | cut -f5 -d:` # ID of the last username

							

							########################## START POINT ###############################
      
    								            # Calling login function # 
                         
      									                 Login


						    ######################################################################