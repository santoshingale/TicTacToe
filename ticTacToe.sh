#!/bin/bash -x
echo "Welcome to TicTacToe game"
declare -a board
board=(1 2 3 4 5 6 7 8 9)

function getLetterAssigment(){

	case $(( RANDOM % 2 )) in
		1) echo X;;
		0) echo O;;
	esac
}

function toss(){

	player=$( getLetterAssigment )

	if [ $player == 'X' ]
	then
		echo X
	else
		echo O
	fi
}
function printBoard(){
	echo "-------------"
	for((i=0;i<9;i+=3))
	do
		echo "| "${board[$i]}" | "${board[ $i + 1 ]}" | "${board[ $i + 2 ]}" |"
		echo "-------------"
	done
}
function setCell(){
	printBoard

	if [ $player == $turn ]
	then

		read -p "Enter Cell number" cell

		if [[ $cell -gt 9 || $cell -lt 0 ]]
		then
			echo "Input is invalid"
			setCell
		elif [ ${board[$cell-1]} -eq $cell ]
		then
			board[$cell-1]=X
		else
		echo "Input is invalid or Cell is pre allocated"
		setCell
		fi

	fi
}
#setCell
#printBoard
turn=$(toss)
echo $turn
setCell
printBoard
