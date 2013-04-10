#!/bin/bash
if [ "x$(whoami)" != "xroot" ]; then
    echo "Only root can run this script."
    exit 1
fi

cd /opt/git/note.git
git config --add core.sharedRepositoy group
chgrp  -R notedev /opt/git/note.git
chmod g+rsw -R /opt/git/note.git
echo "#!/bin/sh\n chgrp -R notedev . 2>/dev/null" > /opt/git/note.git/hooks/post-update
chmod g+x /opt/git/note.git/hooks/post-update
