#!/bin/bash

echo "$2" | grep -q "$1"

if [ $? -ne 1 ]
then
    echo "$1 está contida em $2"
fi