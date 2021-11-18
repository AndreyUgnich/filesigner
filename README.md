# signfile

signfile is added sign to each filename, based on file content.  

For examle, file without content called "empty.jpg" will be renamed to:

"empty.d41d8cd98f00b204e9800998ecf8427e.jpg" (using md5sum as signer - default)

or to:

"empty.da39a3ee5e6b4b0d3255bfef95601890afd80709.jpg" (using sha1sum as signer)

It is possible to sign one or many files:

./signfile.sh empty.jpg

./signfile.sh *.jpg
