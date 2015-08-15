#! /usr/bin/env bash

set -e
set -u
set -x

local_docs () {
    echo Build local docs
    dot -Tsvg projects_diagram.dot -o projects_diagram.svg
    echo index
    asciidoctor index.asciidoc -o - | runhaskell AddLinks.lhs > index.html
    # todo: fix svg title
    # todo: fix svg tag in html
    cabal sandbox init
    cabal install split
    runhaskell -package-db=.cabal-sandbox/x86_64-linux-ghc-7.10.2-packages.conf.d/ FixStuff.lhs
    echo hssqlppp/index
    asciidoctor hssqlppp/index.asciidoc -o - | runhaskell AddLinks.lhs ".." > hssqlppp/index.html
    echo simple-sql-parser/index
    asciidoctor simple-sql-parser/index.asciidoc -o - | runhaskell AddLinks.lhs ".." > simple-sql-parser/index.html
}

all_docs () {
    echo Build subproject docs

    echo sql-overview
    #(cd ../../sql-overview/master && ./make_website.sh && cp -R build/* ../../jakewheat.github.io/master/sql-overview/ && cd -)

    echo intro_to_parsing
    #(cd ../../intro_to_parsing/master && ./make_website.sh && cp -R build/index.html ../../jakewheat.github.io/master/intro_to_parsing/ && cd -)

    #echo hssqlppp
    (cd ../../hssqlppp/master && make website website-haddock && cp -R build/website/* ../../jakewheat.github.io/master/hssqlppp/0.5.18/ && cd -)

    echo simple-sql-parser
    #(cd ../../simple-sql-parser/master && make website && cp -R build/* ../../jakewheat.github.io/master/simple-sql-parser/0.5.0 && cd -)

    local_docs
}

usage () {
    echo please use either
    echo ./make_website all
    echo or
    echo ./make_website local
}


if [[ $# != 1 ]]
then
    usage
    exit
fi

while [[ $# > 0 ]]
do
key="$1"

case $key in
    all)
        all_docs
        shift
        ;;
    local)
        local_docs
        shift
        ;;
    *)
        usage
        exit;;
esac
done
