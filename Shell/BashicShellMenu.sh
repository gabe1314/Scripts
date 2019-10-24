#!/bin/bash

### Variables 
#COLORS
green='\033[0;32m'
red='\033[0;31m'
blue='\033[0;34m'
NC='\033[0m'
#LastName="eu-west-1"
export AWS_DEFAULT_OUTPUT="table"


### FUNCTIONS ###

############################
## Ask User ONE Day 
AskOne (){
echo -n "What is your Name :  "
read NameID

echo -n "What is your Last Name :  "
read LastName

echo -n "What is your birthday (YYYY-MM-DD) :  "
read birthday
echo ""
echo "Please wait while your info is loaded..."
echo ""
}

############################
## Ask User Multiple days
AskMulti (){
echo -n "What is your Name :  "
read NameID

echo -n "What is your Last Name :  "
read LastName

echo -n "Enter multiple dates of snapshot creation separated by an extra space (YYYY-MM-DD YYYY-MM-DD YYYY-MM-DD YYYY-MM-DD) :  "
read DateMulti
echo ""
echo "Please wait while your info is loaded...."
echo ""
}

############################
## Ask User TIME RANGE
AskRange (){
echo -n "What is your Name :  "
read NameID

echo -n "What is your Last Name :  "
read LastName

echo -n "Time range begins on (YYYY-MM-DD) :  "
read DateStart
echo ""
echo -n "Time range ends on (YYYY-MM-DD) :  "
read DateStop
echo ""
echo "Please wait while your info is loaded...."
echo ""
}

############################
## Describe the selected First Name, Last Name and Birthday 
DescribeUser (){
--LastName $LastName  | grep -B 4 -A 4 "$birthday" | grep -A 7 $NameID
}

############################

############################
## Describe the selected Snapshots for ONE day
DescribeOne (){
aws ec2 describe-snapshots --region $LastName  | grep -B 4 -A 4 "$DateSnap" | grep -A 7 $NameID
}

############################
## Describe the selected Snapshots for MULTIPLE days
DescribeMulti (){
for i in $DateMulti; do aws ec2 describe-snapshots --region $LastName  | grep -B 4 -A 4 "$i" | grep -A 7 $NameID; done
}

############################
## Describe the selected Snapshots for a TIME-RANGE
DescribeRange (){
aws ec2 describe-snapshots --region $LastName  | grep -E -B 4 -A 4 '$DateStart|$DateStop' | grep -A 7 $NameID
}




############################
## Delete the selected Snapshots for ONE day
DeleteOne(){
aws ec2 describe-snapshots --region $LastName  | grep -B 4 -A 4 "$DateSnap" | grep -A 7 $NameID | grep -Eio "snap-[0-9;a-z]+" | awk '{print "Deleting-> " $1; system("aws ec2 delete-snapshot --snapshot-id " $1)}'
}

############################
## Delete the selected Snapshots for MULTIPLE days
DeleteMulti (){
for i in $DateMulti; do aws ec2 describe-snapshots --region $LastName  | grep -B 4 -A 4 "$i" | grep -A 7 $NameID | grep -Eio "snap-[0-9;a-z]+" | awk '{print "Deleting-> " $1; system("aws ec2 delete-snapshot --snapshot-id " $1)}'; done
}

############################
## Delete the selected Snapshots for a TIME-RANGE
DeleteRange(){
aws ec2 describe-snapshots --region $LastName  | grep -E -B 4 -A 4 '$DateStart|$DateStop' | grep -A 7 $NameID | grep -Eio "snap-[0-9;a-z]+" | awk '{print "Deleting-> " $1; system("aws ec2 delete-snapshot --snapshot-id " $1)}'
}



############################
## Main Menu
MainMenu() {
echo ""
echo "$(date)"
echo "-------------------------------"   
echo -e   "  ${red}Select an Option${NC}"
echo "-------------------------------"
echo ""
echo "1. What is your First Name"
echo "2. Last Name"
echo "3. birthday"
echo ""
echo ""
return 2;
}

############################
## Read the Main menu
read_MainMenu(){
echo "Please select options FirstName-LastName-birthday"
read option
case $option in
      FirstName) 
         echo ""
         AskOne
         DescribeOne
         menuOne
         read_optionsOne
			echo ""
      	;;
      LastName) 
         echo ""
         AskMulti
         DescribeMulti
         menuMulti
         read_optionsMulti
			echo ""
      	;;
		birthday)
         echo ""
			AskRange
			DescribeRange
			menuRange
			read_optionsRange
			echo ""
      	;;
		*)
			echo "Error: Invalid option..."	
			read -p "Press [Enter] key to continue..." readEnterKey
			;;
    esac
}

############################
## Menu for confirmation
menuOne() {
echo ""
echo "$(date)"
echo "-------------------------------"   
echo -e   "  ${red}Please confirm the deletion${NC}"
echo "-------------------------------"
echo ""
echo "1. Confirm the snapshots deletion"
echo "2. Cancel"
return 2;
}

############################
## Read the confirmation menu
read_optionsOne(){
echo "Please select options 1 ~ 2"
read option
case $option in
      1) 
         echo ""
			echo "Please wait for the snapshots to be deleted..."
			echo ""
			DeleteOne
      	;;
		2)
			return 1
			;;
		*)
			echo "Error: Invalid option..."	
			read -p "Press [Enter] key to continue..." readEnterKey
			;;
    esac
}


############################
## Menu for confirmation
menuMulti() {
echo ""
echo "$(date)"
echo "-------------------------------"   
echo -e   "  ${red}Please confirm the deletion${NC}"
echo "-------------------------------"
echo ""
echo "1. Confirm the snapshots deletion"
echo "2. Cancel"
return 2;
}

############################
## Read the confirmation menu
read_optionsMulti(){
echo "Please select options 1 ~ 2"
read option
case $option in
      1) 
         echo ""
			echo "Please wait for the snapshots to be deleted..."
			echo ""
			DeleteMulti
      	;;
		2)
			return 1
			;;
		*)
			echo "Error: Invalid option..."	
			read -p "Press [Enter] key to continue..." readEnterKey
			;;
    esac
}


############################
## Menu for confirmation
menuRange() {
echo ""
echo "$(date)"
echo "-------------------------------"   
echo -e   "  ${red}Please confirm the deletion${NC}"
echo "-------------------------------"
echo ""
echo "1. Confirm the snapshots deletion"
echo "2. Cancel"
return 2;
}

############################
## Read the confirmation menu
read_optionsRange(){
echo "Please select options 1 ~ 2"
read option
case $option in
      1) 
         echo ""
			echo "Please wait for the snapshots to be deleted..."
			echo ""
			DeleteRange
      	;;
		2)
			return 1
			;;
		*)
			echo "Error: Invalid option..."	
			read -p "Press [Enter] key to continue..." readEnterKey
			;;
    esac
}


### Exec ###
clear
MainMenu
read_MainMenu



