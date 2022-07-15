#!/bin/bash


if [ $1 -lt $2 ]
then
    echo "$1 é menor que $2"
fi

if [ $1 -gt $2 ]
then
    echo "$1 é maio que $2"
else
    echo "$1 é igual a $2"
fi