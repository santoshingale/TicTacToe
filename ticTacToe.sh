#!/bin/bash -x
echo "Welcome to TicTacToe game"

declare -a board
board=(1 2 3 4 5 6 7 8 9)
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

	if [ $player == $turn ]
	then

		read -p "Your Turn Enter Cell number : " cellNumber

		if [ ${board[$cellNumber-1]} -eq $cellNumber ] && [ $cellNumber -le 9 ] && [ $cellNumber -gt 0 ]
		then
			board[$cellNumber-1]=$turn
		else
			echo "Input is invalid or Cell is pre allocated"
			setCell
		fi

	else
		computerMove
	fi
}

function computerMove(){

	flag=0
	checkWinning $computer
	checkWinning $player
	checkCorners
	checkCenter
	checkSides
}

function checkCorners(){
	for((i=0;i<9;i++))
	do
		if [ ${board[$i]} == $(( $i+1 )) ] && [ $(( $i % 2 )) == 0 ] && [ $i != 4 ] && [ $flag == 0 ]
		then
			board[$i]=$computer
			flag=1
			break
		fi
	done
}

function checkCenter(){
	if [ ${board[4]} == 5 ] && [ $flag == 0 ]
	then
		board[$i]=$computer
		flag=1
	fi
}

function checkSides(){
   for((i=0;i<9;i++))
   do
      if [ ${board[$i]} == $(( $i+1 )) ] && [ $(( $i % 2 )) != 0 ] && [ $i != 4 ] && [ $flag == 0 ]
      then
         board[$i]=$computer
         flag=1
         break
      fi
   done
}

function checkWinner(){

	for((i=0,k=3;i<3;i++,k+=3))
	do
		check=""

		for((j=i*3;j<k;j++))
		do
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

function checkWinning(){

	z=0

	while [ $z -lt 9 ] && [ $flag == 0 ]
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
				((flag++))
				echo "$z"
				break
			else
				board[$z]=$temp
			fi
		fi
		((z++))
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
	printBoard
	echo -e "Player symbol : $player \nComputer symbol : $computer"

	while [ $winner == "null" ] && [ $loop -le 9 ]
	do
		setCell
		checkWinner
		changeTurn
		printBoard
		((loop++))
	done

	printBoard

	case $winner in
		X)echo "X is winner" ;;
		O)echo "O is winner" ;;
		*)echo "Match draw" ;;
	esac
}

main
