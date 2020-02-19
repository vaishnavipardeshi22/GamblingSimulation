#!/bin/bash -x

echo " ****************************** WELCOME TO GAMBLING SIMULATION ****************************** "

#CONSTANTS

STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
MIN_WIN=$(( STAKE_PER_DAY * 50 / 100 ))
MAX_WIN=$(( STAKE_PER_DAY + MIN_WIN ))

#VARIABLE
stake=$STAKE_PER_DAY

#CHECKING GAMBLER WIN OR LOOSE THE BET AND CALCULATE THE STAKE
while [ $stake -gt $MIN_WIN -a $stake -lt $MAX_WIN ]
do
	gamblerCheck=$(( RANDOM % 2 ))

	if [ $gamblerCheck -eq $WIN ]
	then
		stake=$(( stake + BET_PER_GAME ))
	else
		stake=$(( stake - BET_PER_GAME))
	fi
done
