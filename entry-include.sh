#!/bin/bash

script=$1
cmd=$2
. $script

case $cmd in 
    build)
        build
        ;;
    run)
        run $3
        ;;
    *)
        echo invalid command
        ;;
esac
