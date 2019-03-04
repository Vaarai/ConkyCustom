#!/bin/bash

for filename in ./*.png; do
     convert $filename -resize 24x24 ./small/$filename
done