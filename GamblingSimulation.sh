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
function getMonthlyStakeArray()
{
	winDays=0
	lostDays=0

	for(( days=1; days<=$TOTAL_DAYS; days++ ))
	do
		totalDailyStake=$(calculateDailyStake)
		if [ $totalDailyStake -ge 0 ]
		then
			((winDays++))
		else
			((lostDays++))
		fi
		totalStake=$(( totalStake + totalDailyStake ))
		dailyStakeArray[$days]=$totalStake
	done
	echo ${dailyStakeArray[@]}
}

#FUNCTION TO GET LUCKIEST DAY
function getLuckiestDay()
{
	maxStake=${dailyStakeArray[1]}
	for(( day=1; day<=${#dailyStakeArray[@]}; day++ ))
	do
		if [ ${dailyStakeArray[day]} -gt $maxStake ]
		then
			maxStake=${dailyStakeArray[day]}
			luckyDay=$day
		elif [ $maxStake -eq ${dailyStakeArray[day]} ]
		then
			luckyDay=$luckyDay" "$day
		fi
	done
	echo $luckyDay
}

#FUNCTION TO GET UNLUCKIEST DAY
function getUnluckiestDay()
{
	minStake=${dailyStakeArray[1]}
	for(( day=1; day<=${#dailyStakeArray[@]}; day++ ))
	do
		if [ ${dailyStakeArray[day]} -lt $minStake ]
		then
			minStake=${dailyStakeArray[day]}
			unluckyDay=$day
		elif [ $minStake -eq ${dailyStakeArray[day]} ]
		then
			unluckyDay=$unluckyDay" "$day
		fi
	done
	echo $unluckyDay
}

getMonthlyStakeArray
LuckiestDay=$(getLuckiestDay)
UnluckiestDay=$(getUnluckiestDay)
totalWonAmount=$(( winDays * MIN_WIN ))
totalLostAmount=$(( lostDays * MIN_WIN ))


