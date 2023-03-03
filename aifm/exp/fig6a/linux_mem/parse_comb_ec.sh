#!/bin/bash

echo -e "load (mops),50% tail lat(cycles),90% tail lat (cycles),50% tail encr+cmpr lat (cycles),90% tail encr+cmpr lat (cycles)" > summary
ls log.* | xargs -I {} sh -c 'cat {} | sed "s/mops = \(.*\)/\1/g" | sed "s/.* = \(.*\)/\1/g" | xargs | sed "s/ /,/g"' | sort -k 1,1n >> summary
capacity=`tail -n 1 summary | cut -f1 -d ,`
inf=100000000
awk "BEGIN{printf \""%s,%s\\n\"",$capacity*1.05,$inf}" >> summary
