#!/bin/bash
# mensagem.sh
# 
# Mostra mensagem colorida na tela, lendo os dados de um arquivo de
# configuração externo utilizando um parser (parser01.sh). O parser
# é utilizado para buscar o valor de uma chave específica que é usado
# para setar uma variável nativa do programa mensagem.sh
# 
# 
# Jul 2022, Yuri


CONFIG=mensagem.conf        # Arquivo de configuração
source parser01.lib          # Inclui as funções contidadas em parser01.sh

# Configurações (serão lidas do $CONFIG)
USAR_CORES=0                    # config: UsarCores
COR_LETRA=                      # config: CorLetra
COR_FUNDO=                      # config: CorFundo
MENSAGEM='Mensagem padrão'      # config: Mensagem

## Processando valores
[ "`pegarValor usarcores | tr A-Z a-z`" = "on" ] && USAR_CORES=1
COR_LETRA=`pegarValor corletra | tr -d -c 0-9`
COR_FUNDO=`pegarValor corfundo | tr -d -c 0-9`
MSG=`pegarValor mensagem`
[ "$MSG" ] && MENSAGEM=$MSG


# Configurações lidas, mostre na tela
if [ "$USAR_CORES" -eq 1 ]; then
    # Mostrar mensagem colorida
    echo -e "\e[$COR_FUNDO;${COR_LETRA}m$MENSAGEM\e[m"
else
    # Não usa cores
    echo "$MENSAGEM"
fi