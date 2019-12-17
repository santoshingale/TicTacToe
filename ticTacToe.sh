#!/bin/bash -x
echo "Welcome to TicTacToe game"

declare -a board
board=(1 2 3 4 5 6 7 8 9)
player=""
turn=""
winner="null"
function getLetterAssigment(){

	case $(( RANDOM % 2 )) in
		1) echo "X";;
		0) echo "O";;
	esac
}

function toss(){

	player=$(getLetterAssigment)
	echo "X $player"
}

function printBoard(){
	echo "-------------"
	for((i=0;i<9;i+=3))
	do
		echo "| "${board[$i]}" | "${board[ $i + 1 ]}" | "${board[ $i + 2 ]}" |"
		echo "-------------"
	done
}

function changeTurn(){

	if [ $turn == "X" ]
	then
		turn="O" 
	else
		turn="X"
	fi

}

function setCell(){

	printBoard

	while true
	do

		if [ $player == $turn ]
		then

			read -p "Enter Cell number" cellNumber

			if (( $cellNumber > 9 || $cellNumber < 0 ))
			then
				echo "Input is invalid"
			elif (( ${board[$cellNumber-1]} == $cellNumber ))
			then
				board[$cellNumber-1]=$turn
				checkWinner
				changeTurn
				break
			else
				echo "Input is invalid or Cell is pre allocated"
			fi

		else

			random=$((RANDOM % 9 + 1))

			if (( ${board[$random-1]} == $random ))
			then
				board[$random-1]=$turn
				checkWinner 
				changeTurn
				break
			fi

		fi
done
}

function checkWinner(){
	check=""
	for((i=0,k=3;i<3;i++,k+=3))
	do
		check=""
		for((j=i*3;j<k;j++))
		do
			#echo $j
			check=$check"${board[$j]}"
		done
			checkLine $check

		check=""

		for((s=i;s<9;s+=3))
		do
			check=$check"${board[$s]}"
		done
		checkLine $check
		firstDigonal="${board[0]}${board[4]}${board[8]}"
		checkLine $firstDigonal
		secondDigonal="${board[2]}${board[4]}${board[6]}"
		checkLine $secondDigonal
	done
}

function checkLine(){
	line=$1

	if [ $line == "XXX" ]
	then
		winner=$turn
		echo "Winner "$winner
	elif [ $line == "OOO" ]
	then
		winner=$turn
		echo "winner "$winner
	fi

}
function main(){
	read turn player < <(toss)
	loop=1
	while [ $winner == "null" ] && [ $loop -le 9 ]
	do
		setCell
		((loop++))
	done
}
main
