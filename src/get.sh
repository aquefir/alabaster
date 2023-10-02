stdbuf -o0 /bin/echo -n 'Downloading {{1}}... ';
curl -fsSL '{{2}}' > '{{3}}';
/bin/echo 'done.';
