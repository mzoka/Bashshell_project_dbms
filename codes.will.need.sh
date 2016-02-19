https://help.gnome.org/users/zenity/stable/

http://www.linux-magazine.com/Issues/2009/99/Zenity-and-KDialog


#grid view
ListTable=$(zenity  --list  --title "All Data in table " --checklist  --column "$FirstCol" --column "$SecondCol" --column "$FirstCol" --column "$SecondCol"  --weidth=600 --separator=":"); echo $ListTable


#progress bar 
zenity --progress --time-remaining  --percentage=10

#authentication
  zenity --password "Please enter the server access code:"
    if [ $? = 0 ]; then
            echo " you selected: OK"
    else
            echo " you selected: Cancel"
    fi

#Done statment 
zenity --info --text="Done"
zenity --info --text="`ls`"

#Error msg
zenity --error \
--text="Could not find /var/log/syslog."

#options 
--calendar
--color-selection
--file-selection
--forms
--list
--notification
--password
--progress
--scale
--entry
--text-info
--error
--warning
--question
--info


#multi choice menu

zenity --list \
 --title="Choose your OS" \
 --column="OS" --column="Interface" \
  Ubuntu Unity \
  "OS X" Marble \
  FreeBSD "Command line" \
  Fedora GNOME \
  Minix Command_line \
  Pidora XFCE \
  Lubuntu LXDE \
  "MS-Windows" Metro



