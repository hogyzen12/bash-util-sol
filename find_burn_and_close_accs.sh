#!/bin/bash

#print initial balance
init=`solana balance`
#pull the token accs on the wallet
spl-token accounts > accs.txt
#grep and pull tokens 
#grep "  1" accs.txt > burn-tokens.txt
#do some fancy replacing here to prep for running solana cli
#sed -i 's/  1//g' burn-tokens.txt

#check here if burnt token to find acc ready to close
grep "  0" accs.txt > close-accounts.txt
sed -i 's/  0//g' close-accounts.txt

#read in the file as needed
#file="/home/hogyzen12/recover-token-rent/burn-tokens.txt"
file="/home/hogyzen12/recover-token-rent/close-accounts.txt"

while IFS= read -r line
do
    #here we parse the account address from the token adress, and strip it into a variable ready to burn
    #burn=`spl-token account-info $line --output json | jq ".address" | sed 's/"//g'`
    #echo $burn
    #spl-token burn $burn 1
    #sleep 1
    #echo $line
    spl-token close $line
    sleep 1
done <"$file"

final=`solana balance`

echo "u had $init and after closing u have $final"