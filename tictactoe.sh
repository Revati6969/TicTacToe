#!/bin/bash -x
echo "Welcome to Tictactoe game"
row=3
column=3
function initializeBoard(){  #Uc1 function to create board
	for((r=0; r<$row; r++))
	do
		for((	c=0; c<$column; c++))
		do
			board[$r,$c]="-"
		done
	done
}
initializeBoard
function displayBoard(){  #finction to displayboard
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
