stdbuf -o0 /bin/echo -n 'Unzipping {{1}}... ';
unzip -q -o '{{2}}' -d '{{3}}';
/bin/echo 'done.';
