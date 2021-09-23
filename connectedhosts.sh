#!/bin/bash
# This script generates a list of ip addresses connected to ravend
# This script assumes ranvend is running
# get the connected hosts
printf "\nConnected Hosts:\n\n"
/usr/local/bin/raven-cli getpeerinfo | \
	jq -r '("Address\tVersion\tInbound\tBytesSent\tBytesRcv"), (.[] | "\(.addr) \(.subver) \(.inbound) \(.bytessent) \(.bytesrecv)")' | \
	sed 's|/||g' | \
	column -t | \
	awk '1; END { print "\nTotal Connections:", NR-1, "\n" }'
