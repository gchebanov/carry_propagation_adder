#!/usr/bin/env bash

awk "{if (length(\$0)==0) {f=1;} else if (f==1&&g==0) {print(\$1); g=1}}/;/{g=0}" build/rtl_rca32/job0/export/1/outputs/rtl_rca.vg  | sort | uniq -c | sort -nr