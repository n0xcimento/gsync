#!/bin/bash
# 
# mensagem.sh
# Mostra mensagem colorida na tela, lendo os dados
# de um arquivo de configuração externo.
# 
# Aqui o script utiliza o parser.sh para pegar os valores das chaves
# contidas em um aquivo de configuração externo e declara elas como variáveis
# e, então, utiliza-as.
# 
# Jul 2022, Yuri Nascimento


CONFIG="mensagem.conf"           # Arquivo de configuração

# Configurações (serão lidas do $CONFIG)
USAR_CORES=0                    # config: UsarCores
COR_LETRA=                      # config: CorLetra
COR_FUNDO=                      # config: CorFundo
MENSAGEM='Mensagem padrão'      # config: Mensagem


# Carrega a configuração do arquivo externo
# A partir da saída do parser00.sh, eval declara as variáveis
eval `./parser00.sh $CONFIG`
# eval é perigoso, posto que o conteúdo da variável será
# executado como um comando normal do shell.

# Processando os valores
[ "`echo $CONF_USARCORES | tr A-Z a-z`" = "on" ] && USAR_CORES=1

# Apenas números
COR_FUNDO=`echo $CONF_CORFUNDO | tr -d -c 0-9`
COR_LETRA=`echo $CONF_CORLETRA | tr -d -c 0-9`

[ "$CONF_MENSAGEM" ] && MENSAGEM=$CONF_MENSAGEM


# Configurações lidas, mostre na tela
if [ "$USAR_CORES" -eq 1 ]; then
    # Mostrar mensagem colorida
    echo -e "\e[$COR_FUNDO;${COR_LETRA}m$MENSAGEM\e[m"
else
    # Não usa cores
    echo "$MENSAGEM"
fi