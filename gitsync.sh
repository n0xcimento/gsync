#!/bin/bash

# Manda mudanças de diretórios padrões para o github, bem como baixa mudanças desses diretórios para o local,
# de modo automático. O objetivo, aqui, é tentar manter os conteúdos desses diretórios sempre synchronizados,
# para evitar conflitos em pull ou push.

commit_msg () {    
    # mensagem que irá ser passada para o `git commmit -m`
    COMMIT_MSG=""

    # [tipo-de-alteração]nome-do-arquivo
    test "$1" = "ebook" && COMMIT_MSG="$(git -C "$HOME/ebook" status | awk '/(deleted|modified):/{print "["substr($1, 1, 1)"]"$2" +"}' | tr '\n' ' ')"

    test "$1" = "Periodo.05" && COMMIT_MSG="$(git -C "$HOME/Periodo.05" status | awk '/(deleted|modified):/{print "["substr($1, 1, 1)"]"$2" +"}' | tr '\n' ' ')"

    COMMIT_MSG=${COMMIT_MSG:0: -3}
    echo $COMMIT_MSG
}


main () {
    
    git -C "$HOME/ebook" status | grep -qE '(deleted|modified):'
    
    test "$?" = "0" && MSG=$(commit_msg "ebook") # caso haja alterações em ebook dir, gera msg de commit
   
    git -C "$HOME/Periodo.05" status | grep -qE '(deleted|modified):'

    test "$?" = "0" && MSG=$(commit_msg "Periodo.05") # caso haja alterações em Periodo.05 dir, gera msg de commit

    echo "$MSG"
}

main "$@"