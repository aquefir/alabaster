#!/bin/sh
#

/bin/echo -n "/bin/echo -n " > "$3";
cat "$1" | plzip -c9n 8 | base64 | sed -z 's/\n//g' >> "$3";
/bin/echo " | base64 -d | plzip -dc > '$2'" >> "$3";
