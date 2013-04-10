#!/bin/bash
if [ "x$(whoami)" != "xroot" ]; then
    echo "Only root can run this script."
    exit 1
fi

rev1="$1"

if [ "x${rev1}" != "xexp" ] && [ "x${rev1}" != "xmaster" ]; then
    echo "Usage: $(basename $0) {master|exp} "
    exit 1
fi

cd /opt/git/note.git
git archive master -o /tmp/note.tgz
ret=$?
if [ "x${ret}" != "x0" ]; then
    echo "An error occurs when archiving."
    exit 1
fi

if [ "${rev1}"="master" ]; then

    mkdir -p /opt/note
    cd /opt/note
    tar xf /tmp/note.tgz

    cp /opt/note/conf/nginx/master /etc/nginx/sites-available/note-master
    ln -s /etc/nginx/sites-available/note-master /etc/nginx/sites-enabled/note-master
    nginx -t
    ret=$?
    if [ "x${ret}" != "x0" ]; then
        echo "An error occurs when check nginx -t"
        exit 1
    fi
    /etc/init.d/nginx reload

    echo "Please type mysql root password:"
    mysql -uroot -p  --default-character-set=utf8 < /opt/note/doc/sql/init_database.sql

    sh /opt/note/tool/export.sh master


elif [ "${rev1}"="exp" ]; then
    mkdir -p /opt/note_exp
    cd /opt/note_exp
    tar xf /tmp/note.tgz

    cp /opt/note_exp/conf/nginx/exp /etc/nginx/sites-available/note-exp
    ln -s /etc/nginx/sites-available/note-exp /etc/nginx/sites-enabled/note-exp
    nginx -t
    ret=$?
    if [ "x${ret}" != "x0" ]; then
        echo "An error occurs when nginx -t"
        exit 1
    fi
    /etc/init.d/nginx reload

    sh /opt/note_exp/tool/export.sh exp

fi
