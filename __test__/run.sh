#!/bin/bash

default='App::ansiecho'
default='App::Greple App::ansiecho Acme'
default='App::Greple App::sdif App::ansiecho Acme'

while getopts "ld" OPT
do
    case $OPT in
	l)
	    echo ${default:?}
	    exit
	    ;;
	d)
	    use_default=1
	    ;;
    esac
done	
shift $((OPTIND - 1))

[ "$use_default" != '' ] && set ${default:?}

test $# -gt 0

(( success = 0 ))
for tool in $*
do
    case $tool in
	Acme)
	    [ $? == 0 ] && echo "ok - $tool" && (( success++ ))
	    ;;
	App::Greple)
	    greple root /etc/passwd
	    [ $? == 0 ] && echo "ok - $tool" && (( success++ ))
	    ;;
	App::sdif)
	    which sdif && which cdif && which watchdiff
	    [ $? == 0 ] && echo "ok - $tool" && (( success++ ))
	    ;;
	App::ansifold|App::ansicolumn|App::ansiexpand)
	    cmd=$(echo $tool | sed 's/.*:://')
	    which $cmd
	    [ $? == 0 ] && echo "ok - $tool" && (( success++ ))
	    ;;
	App::ansiecho)
	    ansiecho -C '555/#850029' d i g i t a l
	    [ $? == 0 ] && echo "ok - $tool" && (( success++ ))
	    ;;
	*)
	    echo "$tool: unknown"
	    false
	    ;;
    esac
done

echo "$success/$# test passed"
(( success == $# )) || exit 1
