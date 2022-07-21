#!/bin/bash
# 
# mensagem.sh
# Mostra mensagem colorida na tela, lendo os dados
# de um arquivo de configuração externo.
# 
# versão 01: Trata os valores das chaves em minúscula e maiúscula.
#            Para o processamento, as chaves de CONFIG ficam em minúsculas.
# 
# Jul 2022, Yuri Nascimento


CONFIG="mensagem.conf"           # Arquivo de configuração

# Configurações (serão lidas do $CONFIG)
USAR_CORES=0                    # config: UsarCores
COR_LETRA=                      # config: CorLetra
COR_FUNDO=                      # config: CorFundo
MENSAGEM='Mensagem padrão'      # config: Mensagem


# Loop para ler linha a linha da configuração, guardando em $LINHA
while read LINHA; do
    # $LINHA sem aspas para que brancos do início e fim da linha sejam
    # removidos; e espaços e TABs entre as palavras sejam convertidos
    # em apenas um espaço.

    # Ignora as linhas de comentários
    [ "`echo $LINHA | cut -c1`" = '#' ] && continue

    # Ignora as linhas em branco
    [ "$LINHA" ] || continue

    # Linhas importantes
    # echo +++ $LINHA

    # Guardar cada palavra da linha em $1, $2, $3, ...
    set - $LINHA

    ## Extraindo os dados
    # Primeiro pegamos a chave, o resto é o valor dela
    chave=`echo $1 | tr A-Z a-z`    # chave(.conf) em minúscula
    shift
    valor=$*

    # Conferindo valor e chave
    # echo "+++ $chave --> $valor"

    # Processando as configurações em $CONFIG
    # Como as chaves(.conf) foram convertidas para minúsculas, em cada
    # case elas são verificadas em minúsculas.
    case "$chave" in

        usarcores)
            [ "`echo $valor | tr A-Z a-z`" = 'on' ] && USAR_CORES=1
        ;;

        corfundo)
            COR_FUNDO=`echo $valor | tr -d -c 0-9` # apenas números
        ;;

        corletra)
            COR_LETRA=`echo $valor | tr -d -c 0-9` # apneas números
        ;;

        mensagem)
            [ "$valor" ] && MENSAGEM=$valor
        ;;

        *)
            echo "Erro no arquivo de configuração"
            echo "Opção/chave desconhecida: '$chave'"
            exit 1
        ;;
    esac

done < "$CONFIG"


# Configurações lidas, mostre na tela
if [ "$USAR_CORES" -eq 1 ]; then
    # Mostrar mensagem colorida
    echo -e "\e[$COR_FUNDO;${COR_LETRA}m$MENSAGEM\e[m"
else
    # Não usa cores
    echo "$MENSAGEM"
fi