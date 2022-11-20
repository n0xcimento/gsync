#!/bin/bash

commit_msg () {
    # Gera a mensagem que irá ser mandada para o `git commit -m`. Aqui, a mensagem gerada será o [tipoDeModificação]nomeAquivo ou [tipoDeModificação]nomeDiretório
    
    # mensagem que irá ser passada para o `git commmit -m`
    COMMIT_MSG=""

    # [tipo-de-alteração]dir-raiz/nome-do-arquivo

    COMMIT_MSG="$(
        git -C "$HOME/$1" status | awk '/(deleted|modified):/{
            if ( index($2, "/") ) {
                print "["substr($1, 1, 1)"]"substr($2, 1, index($2, "/")) 
            } else { 
                print "["substr($1, 1, 1)"]"$2
            }
        }'
    )"

    echo $COMMIT_MSG | tr '\n' ' '
}

push () {
    # Verifica se há mudanças e, caso haja, pergunta se é para mandar para mandá-las para o repositório remoto.

    MSG=""
    git -C "$HOME/$1" status | grep -qE '(deleted|modified):'

    if [ "$?" = "0" ]; then
        echo -n "Changes in [ $1 ], push [Y/N]: "
        read op

        if test "$op" = "Y"; then
            MSG="$(commit_msg $1)"
            git -C "$HOME/$1" add .
            git -C "$HOME/$1" commit -m "$MSG"
            git -C "$HOME/$1" push
        fi
    fi
}


main () {

    push "ebook"
       
    push "Periodo.05"
}

main "$@"