#!/bin/bash

for i in build/* ; do
	p="$i/job0/export/1/reports/metrics.json"
	if ! [ -f "$p" ]; then
		continue
	fi
	echo "${i:6}" "$(jq ".sc__metric__timing__fmax" "$p")"
done

