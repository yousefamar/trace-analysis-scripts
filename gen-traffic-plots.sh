#!/bin/sh

OUT_DIR="/home/amar/proj/phd/databox/papers/homeIoT/figs"

cd by-mac

for f in *
do
	echo "Gen for $f..."

	cd $f

	rm -rf net-io-$f.csv

	cat conn.log | bro-cut ts orig_ip_bytes resp_ip_bytes \
		| awk '{ print $1, $2 + $3 }' > net-io.csv

	sed -i '1itimestamp,io' net-io.csv
	sed -i 's/\ /,/g' net-io.csv

	Rscript ../../gen-traffic-plot.r

	cp net-io.pdf "$OUT_DIR/net-io-$f.pdf"
	cp net-io-hourly.pdf "$OUT_DIR/net-io-hourly-$f.pdf"

	cd ..
done

