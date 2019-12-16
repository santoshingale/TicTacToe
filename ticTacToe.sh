#!/bin/bash -x
echo "Welcome to TicTacToe game"

board=(1 2 3 4 5 6 7 8 9)

function getLetterAssigment(){

	case $(( RANDOM % 2 )) in
		1) echo X;;
		0) echo O;;
	esac
}

player=$( getLetterAssigment )
