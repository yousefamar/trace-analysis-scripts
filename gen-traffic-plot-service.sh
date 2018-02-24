#!/bin/sh

OUT_DIR="/home/amar/proj/phd/databox/papers/homeIoT/figs"

cat conn.log | bro-cut ts orig_ip_bytes resp_ip_bytes service \
	| awk '{ print $1, $2 + $3, $4 }' > net-io-service.csv

sed -i '1itimestamp,io,service' net-io-service.csv
sed -i 's/\ /,/g' net-io-service.csv
sed -i 's/xmpp,ssl/xmpp ssl/g' net-io-service.csv
#sed -i 's/-/na/g' net-io-service.csv

Rscript ../../gen-traffic-plot-service.r

cp net-io.pdf "$OUT_DIR/net-io-service.pdf"
#cp net-io-hourly.pdf "$OUT_DIR/net-io-hourly-service.pdf"
