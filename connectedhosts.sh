#!/bin/bash
# This script generates a list of ip addresses connected to ravend
# This script assumes ranvend is running

# get the connected hosts
printf "\nConnected Hosts:\n\n"
/usr/local/bin/raven-cli getpeerinfo | \
	# Pull the fields from the json that I want, add table headers and create comma delimited output
	jq -r '("Address,Version,Inbound,BytesSent,BytesRcv,ConnectedSince"), (.[] |"\(.addr),\(.subver),\(.inbound),\(.bytessent),\(.bytesrecv),\((.conntime) | strftime("%B %d %Y %I:%M%p UTC"))")' | \
	# Remove the slashes from the Client Version
	sed 's|/||g' | \
	# Create table from the comma delimited output
	column -t -s","| \
	# Count the connections and output the result
	awk '1; END { print "\nTotal Connections:", NR-1, "\n" }'
