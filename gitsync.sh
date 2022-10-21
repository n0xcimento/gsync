#!/bin/bash

# Manda mudanças de diretórios padrões para o github, bem como baixa mudanças desses diretórios para o local,
# de modo automático. O objetivo, aqui, é tentar manter os conteúdos desses diretórios sempre synchronizados,
# para evitar conflitos em pull ou push.

commit_msg () {    
    # mensagem que irá ser passada para o `git commmit -m`
    COMMIT_MSG=""

    # [tipo-de-alteração]nome-do-arquivo
    COMMIT_MSG="$(git -C "$HOME/ebook" status | awk '/(deleted|modified):/{print "["substr($1, 1, 1)"]"$2" +"}' | tr '\n' ' ')"
    COMMIT_MSG=${COMMIT_MSG:0: -3}
    echo $COMMIT_MSG
}

main () {
    commit_msg "ebook"
    # commit_msg "Periodo.05"
}

main "$@"