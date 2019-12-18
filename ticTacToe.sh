#!/bin/bash -x
echo "Welcome to TicTacToe game"

declare -a board
board=(1 2 3 4 5 6 7 8 9)
player=""
turn=""
winner="null"

function toss(){

	case $(( RANDOM % 2 )) in
		1) player="X"
			computer="O";;
		0) player="O"
			computer="X";;
	esac
	echo "X $player $computer"
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
				break
			else
				echo "Input is invalid or Cell is pre allocated"
			fi

		else

			isPlayerWinning $computer 
			break
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

function isPlayerWinning(){
	z=0
	while [ $z -lt 9 ]
	do
		if [ ${board[$z]} != $computer ] && [ ${board[$z]} != $player ]
		then
			temp=${board[$z]}
			board[$z]=$1
			checkWinner
			if [ $winner != "null" ]
			then
				board[$z]=$turn
				winner="null"
				break
			else
				board[$z]=$temp
			fi
		fi
		((z++))
	done

	if [ $z == 9 ]
	then
		getRandomLocation
	fi
}

function getRandomLocation(){
	while true
	do
		random=$((RANDOM % 9 + 1))
		if [ ${board[$random-1]} == $random ] && [ $z == 9 ]
		then
			board[$random-1]=$turn
			break
		fi
	done
}

function checkLine(){
	line=$1

	if [ $line == "XXX" ]
	then
		winner=$turn
	elif [ $line == "OOO" ]
	then
		winner=$turn
	fi

}

function main(){
	read turn player computer < <(toss)
	loop=1

	while [ $winner == "null" ] && [ $loop -lt 9 ]
	do
		setCell
		checkWinner
		changeTurn
		printBoard
		((loop++))
	done

	case $winner in
		X)echo "X is winner" ;;
		O)echo "O is winner" ;;
		*)echo "Match draw" ;;
	esac
}

main
