#!/bin/bash

NUM=$1

while [ $NUM -ge 0 ]
do
    echo -n "$NUM "
    NUM=$(($NUM-1))
done
    echo