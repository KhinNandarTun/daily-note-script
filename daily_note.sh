#!/bin/bash
#unset update show delete new helpp default
function show_usage () {
	echo "Usage ./daily_note.sh [OPTION] [date(ddJanyyyy)]"
	echo "[OPTION]"
	echo "-n ,	create new note for today, pass the date as today (Eg ./dailynote.sh -n today)"
	echo "-u ,	update the note for that date  "
	echo "-d ,	delete the note for that date "
	echo "-s ,	show the note for that date "
	echo "-h'       for help"
 	return 0

}	

#if [ -z $1 ] || [ "$1" == "--help" ]; then
#	show_usage
#fi

while getopts 'u:s:d:n:h' flag
do 
	case $flag in
		u) update=$OPTARG;;
		s) show=$OPTARG;;
		d) delete=$OPTARG;;
		n) new=$OPTARG;;
		h) helpp=something;;
		*) show_usage ;;	
	esac
done
if [ -n "$new" ]; then
	echo "not null"	
	if [ ! -d $HOME/dailyNote ]; then
		mkdir $HOME/dailyNote
	fi

	cd $HOME/dailyNote
	echo $PWD
	f=$(date +%d%b%Y)
	file=$f.txt
	if [ ! -e $file ] ; then
        	touch $file
		echo " Enter your today work : (if you want to stop ,Enter quit):" 
	else    
		echo "Your today note is already exist and enter your update work:"
	fi	
		read -a text
		while [ $text != "quit" ]; do
			echo  $text >> $file
			read -a text
		done	
	exit
fi	

if [ -n "$update" ]; then
	file=$HOME/dailyNote/$update.txt
	if [ -e $file ]; then
		echo " Enter your update work : (if you want to stop ,Enter quit):" 
        	read -a text
       		while [ $text != "quit" ]; do
                	echo  $text >> $file
                	read -a text
        	done
		echo "Your work is updated at $file "
		exit
	else
		echo "The file you want to update does not exist"
		exit
	fi
fi

if [ -n "$show" ]; then
	file=$HOME/dailyNote/$show.txt
	echo $file
	if [ -e $file ]; then
		cat $file
		exit
	else
		echo "The file you want to look does not exist"
		exit
	fi
fi	

if [ -n "$delete" ]; then
	file=$HOME/dailyNote/$delete.txt
        echo $file
        if [ -e $file ]; then
                rm $file
		echo "Delete is successful"
                exit
        else
                echo "The file you want to delete does not exist"
                exit
        fi
fi
if [ -n "$helpp" ]; then
        show_usage
        exit
fi
exit
