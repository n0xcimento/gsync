#!/bin/bash
# parse.sh
# 
# Lê arquivos de configurações e converte os dados para variáveis
# do shell na saída padrão.
# 
# Jul 2022, Yuri
#
# O aquivo de configuração é indicado na linha de comando
CONFIG=$1

# O arquivo deve existir e ser legível para o usuário que executa o programa
if [ -z "$CONFIG" ]; then
    echo "Uso: parse.sh arquivo.conf"
    exit 1
elif [ ! -r "$CONFIG" ]; then
    echo "Erro: Arquivo sem permissão para leitura: '$CONFIG'"
    exit 1
fi


# Loop para ler linha a linha a configuração, guardando em $LINHA
while read LINHA; do
    # Ignorando as linhas de comentários
    [ "`echo $LINHA | cut -c1 `" = '#' ] && continue

    # Ignorando as linhas em branco
    [ "$LINHA" ] || continue

    # Guardando cada parâmetro da linha em $1, $2, $3, ...
    set - $LINHA

    # Extraindo os dados (chaves sempre maiúsculas)
    chave=`echo $1 | tr a-z A-Z`
    shift
    valor=$*

    # Mostrando chave="valor" na saída padrão
    echo "CONF_$chave=\"$valor\""

done < "$CONFIG"