#! /usr/bin/env bash

if [ "$#" -lt 2 ]; then
	echo "Missing argument: usage: run.sh LOCAL_PATH_INPUT LOCAL_PATH_OUTPUT"
	exit 1
fi

if [ ! -f "$1" ]; then
	echo "File is missing: $1"
	exit 1
fi

if [ ! -f "task4.pig" ]; then
	echo "Script not found: task4.pig"
	exit 1
fi

if [ -z $(which pig 2>/dev/null) ]; then
	echo "Pig installation not found"
	exit 1
fi

output="$PWD/task4-pig/"

rm -rf "$output"
pig -x local -param input="$1" -param output="$output" task4.pig

hadoop fs -getmerge "file://$output" "$2"
hadoop fs -rm -r "file://$output"

exit 0
