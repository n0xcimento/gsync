#!/bin/bash

# Mostra as últimas manchetes do site br-linux.or
# Casa as expressões a partir do .html inicial do site

# Yuri, Jun 2022


URL="http://br-linux.org"
# Os títulos das manchetes estão dentro de <h2><a>
# O sed remove todo o linux, deixando somente o título, de cada manchete.
# O sed também é usado para apagar os tabs iniciais que cada título possui.

lynx -source "$URL" |
    egrep '<h2><a' |
        sed '
            s/<[^>]*>//g 
            s/\t//g'