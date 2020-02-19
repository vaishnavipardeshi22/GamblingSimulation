#!/bin/bash -x

echo " ****************************** WELCOME TO GAMBLING SIMULATION ****************************** "

#CONSTANTS

STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1

#VARIABLES
stake=$STAKE_PER_DAY

#GET RANDOM VALUE FOR GAMBLING
gamblerCheck=$(( RANDOM % 2 ))

#CHECKING GAMBLER WIN OR LOOSE THE BET AND CALCULATE THE STAKE
if [ $gamblerCheck -eq $WIN ]
then
	echo "Gambler wins the bet by \$$BET_PER_GAME."
	stake=$(( stake + BET_PER_GAME ))
else
	echo "Gambler loose the bet by \$$BET_PER_GAME."
	stake=$(( stake - BET_PER_GAME))
fi
