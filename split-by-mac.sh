#!/bin/sh

#
# Splits up a PCAP file by MAC addresses
#
# Authors:
# 	Yousef Amar <yousef@amar.io>
#

if [ $# -lt 1 ]; then
	echo "usage: $0 PCAP_FILE"
	exit
fi

DIR=$(dirname "$1")

if [ ! -f "$DIR/dhcp.log" ]; then
	echo "Please run bro on $1 in the directory $DIR."
	exit 1
fi

if ! [ -x "$(command -v bro-cut)" ]; then
	echo "Please install Bro Auxilliary Tools."
	exit 1
fi

mkdir -p "$DIR/by-mac"

for MAC in $(cat "$DIR/dhcp.log" | bro-cut mac | sort | uniq)
do
	echo "Filtering to $DIR/by-mac/$MAC.pcap"
	tcpdump -r $1 -w "$DIR/by-mac/$MAC.pcap" ether host "$MAC"
done