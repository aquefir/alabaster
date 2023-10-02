stdbuf -o0 /bin/echo -n 'Untarballing {{1}}... ';
tar -C '{{3}}' -xf '{{2}}';
/bin/echo 'done.';
