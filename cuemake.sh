#!/bin/bash

while getopts ":b:o:" opt; do
	case $opt in
		b) bin="$OPTARG"
		;;
		o) out="$OPTARG"
		;;
		\?) echo "wrong option specified -$OPTARG"
		;;
	esac
done

if test -z "$bin"
then
	printf 'Target .bin or .BIN not specified\n'
	exit
fi

temp=$bin
ext=${temp:(-4)}
fnme=${temp:0:-4}

if [[ "$ext" != ".bin" && "$ext" != ".BIN" ]]
then
	printf "Expected .bin or .BIN format, got $ext\n"
	exit
fi

if test -z "$out"
then
	out=$PWD
fi

con="FILE \""$bin"\" BINARY
  TRACK 01 MODE2/2352
    INDEX 01 00:00:00"

echo "$con" > "$out/$fnme.cue"
exit
