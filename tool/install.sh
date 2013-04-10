#!/bin/bash
if [ "x$(whoami)" != "xroot" ]; then
    echo "Only root can run this script."
    exit 1
fi

cp /opt/note/conf/nginx/master /etc/nginx/sites-enabled/note
/etc/init.d/nginx restart

echo "127.0.0.1 me.note.com" >> /etc/hosts
