#!/bin/bash

IFS=$'\n'
OFS=$'\n'

e820_mmap=`dmesg|grep BIOS-e820| sed "s/^\[[ 0-9\.]*\] \(.*\)/\1/g" | grep usable`

sum=0
for i in $e820_mmap; do
	mmap=`echo $i | sed "s/^BIOS-e820: \[mem \(0x[0-9a-f]*\)-\(0x[0-9a-f]*\)\] usable$/\2-\1/g"`

	for j in $mmap; do
		echo $i size:$((j))
		sum=$((sum+$((j))))
	done
done
echo "Total usable mem region size: " $sum
