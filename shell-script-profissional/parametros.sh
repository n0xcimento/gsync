#!/bin/bash

COUNT=1
while [ -n "$1" ]
do
    echo "Parâmetro $COUNT: $1"
    COUNT=$(($COUNT+1))
    shift
done