#!/bin/bash

#mkdir ~/.conky/personnal-Conky

cpu_graph=""
if [ $(grep -c ^processor /proc/cpuinfo) != "4" ] 
then
    cpu_graph="$(cat ./GRAPH_cpu_4)"
else
    cpu_graph="$(cat ./GRAPH_cpu_8)"
fi

graphic_command=""
if [ $(sensors | grep radeon) != "" ] 
then
    graphic_command="$(cat ./GRAPH_graphic_radeon)"
else
    graphic_command="$(cat ./GRAPH_graphic_nvidia)"
fi

cp ./graphs_template.lua ./graphs_test.lua

echo $cpu_graph


sed -i "s/--***cpu_graph/"$cpu_graph"/g" ./graphs_test.lua
sed -i "s/--***graphic/"$graphic_command"/g" ./graphs_test.lua
