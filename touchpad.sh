#!/bin/bash
# touchpad.sh

# touchpach.sh ativa, caso o touchpad esteja desativado, e desativa,
# caso contrário.

# Yuri, Aug 2022

# Nome do dispositivo(touchpad)
AUX=$(xinput | grep -i 'touchpad' | sed 's/id.*//')

# Guarda cada palavra de AUX nos parâmetros posicionais $1 $2 $3 $...
set - $AUX

# descola os dois primeiros caracters que a saída do xinput fornece
shift 2

AUX=""

while [ -n "$1" ]; do

    AUX="$AUX $1"
    shift

done

# Exclui o primeiro caracter(espaço) de AUX
DEVICE_NAME=$(echo $AUX | sed 's/^ //')

# Verifica se o a propriedade de ativação está ativada
# $? = 0 , grep achou a busca
xinput list-props "$DEVICE_NAME" | grep -Eqi 'device enable.*1$'

# Dispositivo está ativado?
IS_ENABLE="$?" # 0: ativado , 1: desativado

if test $IS_ENABLE = 1
then
    xinput enable "$DEVICE_NAME"
else
    xinput disable "$DEVICE_NAME"
fi