#!/bin/bash -eu

##########
# TO RUN LOCALLY
# pushd $REPO_DIR
# FOXYLIB_DIR=$HOME/project/foxylib/foxylib ./backend/scripts/run.bash

ARG0=${BASH_SOURCE[0]}
FILE_PATH=$(readlink -f $ARG0)
FILE_DIR=$(dirname $FILE_PATH)
FILE_NAME=$(basename $FILE_PATH)

errcho(){ >&2 echo "$@"; }
func_count2reduce(){
    local v="${1?missing}"; local cmd="${2?missing}"; local n=${3?missing};
    for ((i=0;i<$n;i++)); do v=$($cmd $v) ; done; echo "$v"
}

REPO_DIR=$(func_count2reduce $FILE_DIR dirname 1)
DOCS_DIR="$REPO_DIR/docs"

main(){
    pushd $DOCS_DIR
    bundle exec jekyll serve
    popd
}

## SAMPLE
# BACKEND=1 ENV=local FOXYLIB_DIR=$HOME/project/foxylib/foxylib ./backend/scripts/run.bash


errcho "[$FILE_PATH] start (REPO_DIR:$REPO_DIR)"
main
errcho "[$FILE_PATH] end (REPO_DIR:$REPO_DIR)"

