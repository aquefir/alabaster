
## INSTALL ADOBE FONTS

stdbuf -o0 /bin/echo -n 'Downloading Source Code Pro... ';

curl -fsSL 'https://github.com/adobe-fonts/source-code-pro/releases/download/2.038R-ro%2F1.058R-it%2F1.018R-VAR/TTF-source-code-pro-2.038R-ro-1.058R-it.zip' > source-code-pro.zip;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Downloading Source Sans Pro... ';
curl -fsSL 'https://github.com/adobe-fonts/source-sans/releases/download/3.046R/TTF-source-sans-3.046R.zip' > source-sans.zip;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Downloading Source Serif Pro... ';
curl -fsSL 'https://github.com/adobe-fonts/source-serif/releases/download/4.004R/source-serif-4.004.zip' > source-serif.zip;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Downloading & installing Source Han Mono... ';
mkdir -p /usr/local/share/fonts/alabaster;
curl -fsSL 'https://github.com/adobe-fonts/source-han-mono/releases/download/1.002/SourceHanMono.ttc' > /usr/local/share/fonts/alabaster/SourceHanMono.ttc;
/bin/echo 'done.'

stdbuf -o0 /bin/echo -n 'Downloading Source Han Sans... ';
curl -fsSL 'https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSans.ttc.zip' > source-han-sans.zip;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Downloading Source Han Serif... ';
curl -fsSL 'https://github.com/adobe-fonts/source-han-serif/releases/download/2.001R/01_SourceHanSerif.ttc.zip' > source-han-serif.zip;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n \
       'Creating Alabaster font folder in /usr/local... ';
mkdir -p /usr/local/share/fonts/alabaster;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Unpacking Source Code Pro... ';
unzip -q -o source-code-pro.zip -x LICENSE.md \
      -d /usr/local/share/fonts/alabaster/;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Unpacking Source Sans Pro... ';
unzip -q -o source-sans.zip -d /usr/local/share/fonts/alabaster/;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Unpacking Source Serif Pro... ';
unzip -q -o source-serif.zip 'source-serif-4.004/TTF/*.ttf' \
      -d /usr/local/share/fonts/alabaster/;
/bin/echo 'done.';

# no Source Han Mono to extract...

stdbuf -o0 /bin/echo -n 'Unpacking Source Han Sans... ';
unzip -q -o source-han-sans.zip -d /usr/local/share/fonts/alabaster/;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Unpacking Source Han Serif... ';
unzip -q -o source-han-serif.zip -d /usr/local/share/fonts/alabaster/;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Cleaning up font packages... ';
rm source-*.zip;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Extracting default wallpaper... ';
mkdir -p /usr/local/share/wallpapers;
