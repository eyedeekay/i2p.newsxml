#!/bin/sh
set -e
. ./etc/project.vars

if [ ! $venv ]; then
    echo "ERROR: virtualenv not found!" >&2
    exit 1
else
    if [ ! -d $venv_dir ] ; then
        if $venv --version | awk -F: '{if($2>20)print$2}' ; then
            $venv $venv_dir
        else
            $venv --distribute $venv_dir
        fi
    fi

    . $venv_dir/bin/activate
    pip install -r etc/reqs.txt
fi
