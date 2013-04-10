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
git archive ${rev1} -o /tmp/note.tgz
ret=$?
if [ "x${ret}" != "x0" ]; then
    echo "An error occurs when archiving."
    exit 1
fi

if [ "${rev1}"="master" ]; then
    cd /opt/note
elif [ "${rev1}"="exp" ]; then
    cd /opt/note_exp
fi

tar xf /tmp/note.tgz

if [ "${rev1}"="master" ]; then
    sed -i "s/#\s*web.config.debug\s*=\s*False/web.config.debug = False/"  /opt/note/web/cgi/app.py
    sed -i "s/'HOST_NAME'\s*:\s*'http:\/\/me.note.com'/'HOST_NAME' : 'http:\/\/note.com'/"  /opt/note/web/cgi/site_helper.py
    python /opt/note/web/cgi/site_helper.py init_dir
    chown www-data:www-data -R /opt/note
    /opt/note/tool/launch.sh restart

elif [ "${rev1}"="exp" ]; then
    sed -i "s/#\s*web.config.debug\s*=\s*False/web.config.debug = False/"  /opt/note_exp/web/cgi/app.py
    sed -i "s/'HOST_NAME'\s*:\s*'http:\/\/me.note.com'/'HOST_NAME' : 'http:\/\/exp.note.com'/"  /opt/note_exp/web/cgi/site_helper.py
    sed -i "s/'APP_ROOT_PATH'\s*:\s*'\/opt\/note\/'/'APP_ROOT_PATH' : '\/opt\/note_exp\/'/"  /opt/note_exp/web/cgi/site_helper.py
    sed -i "s/'APP_PORT'\s*:\s*10040/'APP_PORT' : 10041/" /opt/note_exp/web/cgi/site_helper.py
    sed -i "s/'SESSION_PATH'\s*:\s*'\/opt\/note\/session'/'SESSION_PATH' : '\/opt\/note_exp\/session'/"  /opt/note_exp/web/cgi/site_helper.py
    sed -i "s/'ERROR_LOG_PATH'\s*:\s*'\/opt\/note\/log\/error.log'/'ERROR_LOG_PATH' : '\/opt\/note_exp\/log\/error.log'/"  /opt/note_exp/web/cgi/site_helper.py
    python /opt/note_exp/web/cgi/site_helper.py init_dir
    chown www-data:www-data -R /opt/note_exp
    /opt/note_exp/tool/launch-exp.sh restart

fi
