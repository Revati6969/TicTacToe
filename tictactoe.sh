#!/bin/bash -x

echo "welcome in tic tac toe game"
declare -a boardPosition

#CONSTANTS
PLAYER="X"
COMPUTER="O"
#VARIABLES
turn=9
counter=false
gameCount=1

#TOSS TO PLAY FIRST
function whoPlayFirst() {
	random=$((RANDOM%2))
	if [ $random -eq 1 ]
	then
		echo "PLAYER play first"
		printBoard
		playGame $random
	else
		echo "COMPUTER play first"
		printBoard
		playGame $random
	fi
}

#START GAME
function playGame() {
	flag=$1
  	while [ $counter == false ]
  	do
    		if [ $flag -eq 1 ]
    		then
      			echo "Player Enter your Slot :"
      			read cellNumber
			if [[ ( "${boardPosition[$cellNumber]}" == $PLAYER ) || ( "${boardPosition[$cellNumber]}" == $COMPUTER ) ]]
			then
				echo "Slot already taken, Re-enter slot number"
				playGame $flag
			else
      				boardPosition[$cellNumber]=$PLAYER
      				printBoard
      				checkWinCondition $PLAYER
				flag=0
			fi
        	else
			echo "Computer Enter your Slot :"
			randomCellNumber=$( checkCompWinningCondition )
			echo "randomCellNumber : $randomCellNumber"
			if [[ ( "${boardPosition[$randomCellNumber]}" == $PLAYER ) || ( "${boardPosition[$randomCellNumber]}" == $COMPUTER ) ]]
			then
				echo "Slot already take"
				playGame $flag
			else
				boardPosition[$randomCellNumber]=$COMPUTER
				printBoard
      				checkWinCondition $COMPUTER
				flag=1
			fi
		fi
		((gameCount++))
  	done
}

#COMPUTERS WINNING CONDITIONS
function checkCompWinningCondition(){
	computerRowPosition=$( winComAtRowPosition )
	computerColumnPosition=$( winComAtColoumnPosition )
	computerDiagonalPosition=$( winComAtDiagonalPosition )
	computerTakesCorners=$( takesCorner )
	computerTakesCenter=$( takesCenter )
	computerTakesSide=$( takesSide )

	if [[ $computerRowPosition -gt 0 ]]
	then
		position=$computerRowPosition
	elif [[ $computerColumnPosition -gt 0 ]]
	then
		position=$computerColumnPosition
	elif [[ $computerDiagonalPosition -gt 0 ]]
	then
		position=$computerDiagonalPosition
	elif [[ $computerTakesCenter -gt 0 ]]
        then
		position=$computerTakesCenter
	elif [[ $computerTakesSide -gt 0 ]]
	then
		position=$computerTakesSide
	else
		position=$computerTakesCorner
	fi
	echo $position
}

#COMPUTER CHECK FOR SIDES
function takesSide(){
	local count=1
	if [[ ${boardPosition[$(($count+1))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+1))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+1))
	elif [[ ${boardPosition[$(($count+3))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+3))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+3))
	elif [[ ${boardPosition[$(($count+5))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+5))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+5))
	elif [[ ${boardPosition[$(($count+7))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+7))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+7))
	fi
	echo $positionToReturn
}

#COMPUTER CHECKS FOR CORNERS
function takesCorner(){
	count=1
	positionToReturn=1
	for (( innerLoopCounter=1; innerLoopCounter<=2; innerLoopCounter++ ))
	do
		if [[ ${boardPosition[$count]} -ne $COMPUTER ]] || [[ ${boardPosition[$count]} -ne $PLAYER ]]
		then
			positionToReturn=$count
		elif [[ ${boardPosition[$count+2]} -ne $COMPUTER ]] || [[ ${boardPosition[$count+2]} -ne $PLAYER ]]
		then
			positionToReturn=$(( $count+2 ))
		fi
		count=$(( $count+6 ))
	done
	echo $positionToReturn
}

#COMPUTER CHECKS FOR CENTER
function takesCenter(){
	count=1
	if [[ ${boardPosition[$(($count+4))]} -ne $COMPUTER ]] && [[ ${boardPosition[$(($count+4))]} -ne $PLAYER ]]
	then
		positionToReturn=$(($count+4))	
	fi
	echo $positionToReturn
}

#COMPUTER CHECKS WINNING AT ROWS
function winComAtRowPosition(){
	row=0;
	for (( count=1; count<=3; count++ ))
	do
		row=$(( $row+1 ))
		if [[ ${boardPosition[$row]} == ${boardPosition[$row+1]} ]] || [[ ${boardPosition[$row+1]} == ${boardPosition[$row+2]} ]] || [[ ${boardPosition[$row+2]} == ${boardPosition[$row]} ]]
		then
			for (( innerLoopCounter=$row; innerLoopCounter<=$(($row+2)); innerLoopCounter++ ))
			do
				if [[ ${boardPosition[$innerLoopCounter]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
				then
					positionToReturn=$innerLoopCounter
				fi
			done
		else
			row=$(( $row+3 ))
		fi
	done
	echo $positionToReturn
}

#COMPUTER CHECKS WINNING AT COLUMNS
function winComAtColoumnPosition(){
	column=0;
	for (( count=1; count<=3; count++ ))
	do
		column=$(( $column+1 ))
		if [[ ${boardPosition[$column]} == ${boardPosition[$column+3]} ]] || [[ ${boardPosition[$column+3]} == ${boardPosition[$column+6]} ]] || [[ ${boardPosition[$column+6]} == ${boardPosition[$column]} ]] 
		then
			for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
			do
				if [[ ${boardPosition[$column]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
				then
					positionToReturn=$column
				fi
				column=$(( $column+1 ))
			done
		fi
	done
	echo $positionToReturn
}

#COMPUTER CHECKS WINNING AT DIAGONALS
function winComAtDiagonalPosition(){
	diagCount=1;
	count=1;
	if [[ ${boardPosition[$diagCount]} == ${boardPosition[$diagCount+4]} ]] || [[ ${boardPosition[$diagCount+4]} == ${boardPosition[$diagCount+8]} ]] || [[ ${boardPosition[$diagCount+8]} == ${boardPosition[$diagCount]} ]]
	then
		for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
		do
			if [[ ${boardPosition[$diagCount]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
			then
				positionToReturn=$diagCount
			fi
			diagCount=$(( $diagCount+4 ))
		done
	elif [[ ${boardPosition[$count+2]} == ${boardPosition[$count+4]} ]] || [[ ${boardPosition[$count+4]} == ${boardPosition[$count+6]} ]] || [[ ${boardPosition[$count+6]} == ${boardPosition[$count+2]} ]]
	then
		for (( innerLoopCounter=1; innerLoopCounter<=3; innerLoopCounter++ ))
		do
			count=$(( $count+2 ))
			if [[ ${boardPosition[$count]} -ne $COMPUTER ]] || [[ ${boardPosition[$innerLoopCounter]} -ne $PLAYER ]]
			then
				positionToReturn=$count
			fi
		done
	fi
	echo $positionToReturn
}

#ALL WINNING CONDITIONS FOR BOTH PLAYER AND COMPUTER
function checkWinCondition () {
	checkRows $1
	checkColumns $1
	checkDiagonals $1
	gameTieCheck
}
#WINNING AT ROWS
function checkRows () {
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+1))]} ]] && [[ ${boardPosition[$(($position+1))]} == ${boardPosition[$(($position+2))]} ]] && [[ ${boardPosition[$position]} == $1 ]]
		then
			counter=true
			echo "$1 Won"
			break
		else
			position=$(($position+3))
		fi
		((loopCheck++))
	done
}

#WINNING AT DIAGONALS
function checkDiagonals () {
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+4))]} ]] && [[ ${boardPosition[$(($position+4))]} == ${boardPosition[$(($position+8))]} ]] && [[ ${boardPosition[$position]} == $1 ]]
		then
			counter=true
			echo "$1 Won"
			break
		elif [[ ${boardPosition[$(($position+2))]} == ${boardPosition[$(($position+4))]} ]] && [[ ${boardPosition[$(($position+4))]} == ${boardPosition[$(($position+6))]} ]]  && [[ ${boardPosition[$(($position+2))]} == $1 ]]
		then
			echo "$1 Won"
			counter=true
			break
		fi
		((loopCheck++))
	done
}

#WINNING AT COLUMNS
function checkColumns () {
	loopCheck=1
	position=1
	while [ $loopCheck -le 3 ]
	do
		if [[ ${boardPosition[$position]} == ${boardPosition[$(($position+3))]} ]] && [[ ${boardPosition[$(($position+3))]} == ${boardPosition[$(($position+6))]} ]]  && [[ ${boardPosition[$position]} == $symbol ]]
		then
			echo "$1 Won"
			counter=true
			break
		else
			position=$(($position+1))
		fi
		((loopCheck++))
	done
}

#CHECK TIE OR NOT
function gameTieCheck () {
	if [ $gameCount -ge 9 ]
	then
		echo "Match Tie"
		counter=true
	fi
}

#DISPLAY BOARD
function printBoard () {
	index=1
	for ((Counter=0; Counter<3; Counter++))
	do
		echo "|-----|-----|-----|"
		echo "|  "${boardPosition[counter+index]}"  |  "${boardPosition[counter+index+1]}"  |  "${boardPosition[counter+index+2]}"  |"
		echo "|-----|-----|-----|"
		index=$(($index+3))
	done
}

for (( index=1; index<=9; index++ ))
do
	boardPosition[$index]=$index
done

whoPlayFirst
