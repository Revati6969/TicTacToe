#!/bin/bash -x
echo "Welcome to Tictactoe game"
ROW=3
COLUMN=3

function initializeBoard(){  
	for((r=0; r<$ROW; r++))
	do
		for((	c=0; c<$COLUMN; c++))
		do
			board[$r,$c]="-"
		done
	done
}
initializeBoard
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
function displayBoard(){  
   for((r=0;r<$ROW;r++))
   do
      echo "----------------"
      for(( c=0; c<$COLUMN; c++))
      do
         echo -n "|" ${board[$r,$c]} " " 
      done
      echo 
   done
   echo "----------------"

}
displayBoard
