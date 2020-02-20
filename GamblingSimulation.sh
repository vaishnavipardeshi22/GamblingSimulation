#!/bin/bash -x

echo " ****************************** WELCOME TO GAMBLING SIMULATION ****************************** "

#CONSTANTS

STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
MIN_WIN=$(( STAKE_PER_DAY * 50 / 100 ))
MAX_WIN=$(( STAKE_PER_DAY + MIN_WIN ))
TOTAL_DAYS=30

#FUNCTION FOR CALCULATING STAKE PER DAY
function calculateDailyStake()
{
	local stake=$STAKE_PER_DAY

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
	dailyStake=$(( stake - STAKE_PER_DAY ))
	echo $dailyStake
}

#CALCULATING STAKE FOR A MONTH
for(( days=1; days<=$TOTAL_DAYS; days++ ))
do
	totalStake=$(( totalStake + $(calculateDailyStake) ))

	if [ $totalStake -ge 0 ]
	then
		((winDays++))
	else
		((lostDays++))
	fi
done

#CALCULATING TOTAL AMOUNT OF WIN DAYS AND LOST DAYS IN MONTH
totalwinDaysAmount=$(( winDays * MIN_WIN ))
totallostDaysAmount=$(( lostDays * MIN_WIN ))
