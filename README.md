# Ravencoin-Pi-Node-utils
Utilities to use with your Ravencoin Pi Node

check_status.sh
In the file credit is given to the original authors and this version has a slight tweek by me.
This produces some basic information such as how long ravend has been running and how far behind it is from the current block.
The difference should not be more than a few minutes. If it is, check ~/.raven/debug.log for possible errors.

connectedhosts.sh
This shows the IP addresses and ports of hosts that are connected to ravend. 
This also shows the connected hosts clients information, if the connection is inbound/outbound, and the amount of data transfered to each host