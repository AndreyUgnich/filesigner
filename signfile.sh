#!/bin/bash

# signfile is added sign to each filename, based on file content.  
# For examle, file without content called "empty.jpg" will be renamed to:
# "empty.d41d8cd98f00b204e9800998ecf8427e.jpg" using md5sum as signer (default)
# or to:
# "empty.da39a3ee5e6b4b0d3255bfef95601890afd80709.jpg" using sha1sum as signer
#
# It is possible to sign one or many files:
# ./signfile.sh empty.jpg
# ./signfile.sh *.jpg

signfile () {

	SIGNER=/usr/bin/md5sum;
	#SIGNER=/usr/bin/sha1sum;

	for f in "$@";
	do
		if [[ -f "$f" ]];
		then
			filename_dir=$(dirname "$f");
			filename_base=$(basename -- "$f");
			filename_ext="${filename_base##*.}"
			filename_without_ext="${filename_base%.*}";
			filename_hash="${filename_without_ext##*.}";

			if [[ $filename_hash =~ ^[0-9a-f]{32}$ ]] || [[ $filename_hash =~ ^[0-9a-f]{40}$ ]];
			then
				echo "Skipped: $f";
				continue;
			else
				printf "Signing: $f -> ";
				filename_hash=`$SIGNER "$f" | awk '{print $1}'`;
				echo "$filename_without_ext.$filename_hash.$filename_ext";
				mv "$f" "$filename_dir/$filename_without_ext.$filename_hash.$filename_ext";
			fi;

		else
			echo "$f is not a regular file";
		fi
	done;
}

signfile "$@"

#EOF