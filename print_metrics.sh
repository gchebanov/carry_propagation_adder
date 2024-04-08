#!/bin/bash

for i in build/* ; do
	p="$i/job0/export/1/reports/metrics.json"
	if ! [ -f "$p" ]; then
		continue
	fi
	pn="${i:6}"
	if [ $# -ge 1 ]; then
	  if ! [[ "${pn}" =~ "$1" ]]; then
	    continue
    fi
	fi
	echo -n "${pn} |"
	for metric in ".sc__metric__timing__fmax" ".sc__metric__design__core__area" ".sc__metric__design__instance__area" ".sc__metric__power__total" ".sc__metric__design__instance__count" ; do
    echo -n "$(jq "$metric" "$p") |"
  done
  echo ""
done

