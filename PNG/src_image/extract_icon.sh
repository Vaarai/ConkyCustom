#!/bin/bash

count_x=8
count_y=5
gap_x=123
gap_y=164
space=73
val_x=0
val_y=0

let val_x=$gap_x+2*$space
let val_y=$gap_y+1*$space

convert -depth 8 -extract 48x48+$val_x+$val_y weather-1.png ./out/50n.png
convert -depth 8 -extract 48x48+$val_x+$val_y weather-1.png ./out/50d.png


#for x in $(seq 1 $count_x); do
#    let val_x=$x*$space+$gap_x
#    for y in $(seq 1 $count_y); do
#        let val_y=$y*$space+$gap_y
#        convert -depth 8 -extract 48x48+$val_x+$val_y weather-1.png ./out/$x$y.png
#    done
#done


