#!/bin/bash

# removing old files
rm -rf obs-plgics wdm-glucl
rm -f analyse-obs.sh avg_analyses.py

# getting last verion of the analyse script
git clone https://github.com/niko97320/obs-plgics.git

ln -s obs-plgics/analyse-obs.sh
ln -s obs-plgics/avg_analyses.py

echo "#.. Make sure you have a dcd.txt/dcd_aligned.txt file in the current dir."

echo "#.. Analyzing obs"
bash analyse-obs.sh all -stat 0 > analyse-obs.out &
echo "#.. Analyzing hole profile"
bash analyse-obs.sh hole > analyse-hole.out



