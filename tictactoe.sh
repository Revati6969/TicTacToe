#!/bin/bash -x
echo "Welcome to Tictactoe game"
row=3
column=3
function initializeBoard(){  
	for((r=0; r<$row; r++))
	do
		for((	c=0; c<$column; c++))
		do
			board[$r,$c]="-"
		done
	done
}
initializeBoard
function displayBoard(){  
	for((r=0;r<$row;r++))
	do
		echo "----------------"
		for(( c=0; c<$row; c++))
		do
			echo -n "|" ${board[$r,$c]} " " 
		done
		echo 
	done
	echo "----------------"

}
displayBoard
assignLetter()   
{
   echo "Your latter X"
}
assignLetter
whoPlayFirst() 
{
   play=$(($RANDOM % 2))
   if [[ $play -eq 0 ]]
   then 
      echo player 1 will play first
   else
      echo player 2 will play first
   fi
}
whoPlayFirst

