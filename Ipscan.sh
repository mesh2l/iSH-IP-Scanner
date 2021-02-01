#!/bin/bash
#########################################################
#                  --help--
#
#  iSH IPSCANNER
#
#  type in your devices ip in this format
#  FILE     IP     .ITTER
#  ./ipscan 10.0.0 50
#
#  installation (copy line below and edit)
#  ln -s <path/of/this/file> /bin/ipscan
#
#  100+ parallel pings can crash iSH
#
#  during execution may recieve " host is down" and
#  "host is unreachable" scroll to bottom.
#
#ipaddress=$(ifconfig | grep "netmask" | cut -d " " -f 6)
#ip=$(echo $ipaddress | cut -d "." -f1-3)
#
#  replace $1 with $ip and uncomment ipaddress and ip
#  when ifconfig works, do not add ip perameter when exe
#
#########################################################

echo "---IP_SCAN---" > iplist.txt
#
# reset file each execution

for i in {1..4} ; do      # repeats incase of lost packets
  for ip in `seq 1 $2` ; do
    ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> iplist.txt &
  done
  sleep 3 #keeps from crashing
done

iplist=$(awk '!seen[$0]++' iplist.txt) #remove duplicates
printf '%s\n' "$iplist" > iplist.txt # formatting file

printf "\e[37m\n"
cat iplist.txt # print file wrapped in white
printf "\e[0m\n"
