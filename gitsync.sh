#!/bin/bash

# Manda mudanças de diretórios padrões para o github (ebook e Periodo.05, no meu caso), bem como baixa mudanças
# desses diretórios para o repositório local, de modo automático. O objetivo, aqui, é tentar manter os conteúdos
# desses diretórios sempre sincronizados, para evitar conflitos em pull ou push.


commit_msg () {
    # Gera a mensagem que irá ser mandada para o `git commit -m`. Aqui, a mensagem gerada será o [tipoDeModificação]nomeAquivo ou [tipoDeModificação]nomeDiretório
    
    # mensagem que irá ser passada para o `git commmit -m`
    COMMIT_MSG=""

    # [tipo-de-alteração]nome-do-arquivo
    # test "$1" = "ebook" && COMMIT_MSG="$(git -C "$HOME/ebook" status | awk '/(deleted|modified):/{print "["substr($1, 1, 1)"]"$2}' | tr '\n' ' ')"

    # [tipo-de-alteração]nome-do-arquivo
    # test "$1" = "Periodo.05" && COMMIT_MSG="$(git -C "$HOME/Periodo.05" status | awk '/(deleted|modified):/{print "["substr($1, 1, 1)"]"substr($2, 1, index($2, "/"))}' | tr '\n' ' ')"


    COMMIT_MSG="$(git -C "$HOME/$1" status | awk '/(deleted|modified):/{
        if ( index($2, "/") ) {
            print "["substr($1, 1, 1)"]"substr($2, 1, index($2, "/")) 
        } else { 
            print "["substr($1, 1, 1)"]"$2
        }
    }')"

    echo $COMMIT_MSG | tr '\n' ' '
}

push () {
    # Verifica se há mudanças e, caso haja, pergunta se é para mandar para mandá-las para o repositório remoto.

    MSG=""
    git -C "$HOME/$1" status | grep -qE '(deleted|modified):'

    if [ "$?" = "0" ]; then
        echo -n "Changes in [ $1 ], push [Y/N]: "
        read op

        test "$op" = "Y" && MSG=$(commit_msg "$1")

        echo "$MSG"
    fi
}


main () {

    push "ebook"
       
    push "Periodo.05"
}

main "$@"