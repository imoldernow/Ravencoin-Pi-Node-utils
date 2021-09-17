#!/bin/bash
# This script generates a list of ip addresses connected to ravend
# This script assumes ranvend is running and rpc is enabled on localhost port 8766
# ravend will generate ~/.raven/.cookie if server=1 and rpcuser/rpcpassword are not set
# This script assumes ~/.raven/.cookie exists

# The cookie file doesn't have a line feed so we will make a file that we can read
cp ~/.raven/.cookie ~/.raven/.cleancookie
# Add new line
echo >> ~/.raven/.cleancookie

#Get the id and password from the cookie
while IFS=: read -r USER PASSWORD
do
   # get the connected hosts
   printf "\nConnected Hosts:\n\n"
   curl -sS --user $USER:$PASSWORD --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getpeerinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:8766 | \
	jq -r '("Address\tVersion\tInbound\tBytesSent\tBytesRcv"), (.result[] | "\(.addr) \(.subver) \(.inbound) \(.bytessent) \(.bytesrecv)")' | \
	sed 's|/||g' | \
	column -t | \
	awk '1; END { print "\nTotal Connections:", NR-1, "\n" }'
   done < ~/.raven/.cleancookie

