#!/bin/bash




repo_root=`git rev-parse --show-toplevel`;
index_path="$repo_root/repo/index.txt";

declare -A f_updated; updated_index=0;
declare -A f_up2date; up2date_index=0;




if [ ! -f "$index_path" ]; then
	echo "Abort: couldn't find index: $index_path"
	exit 1;
fi;




for file in `cat "$index_path"`; do
	# Failsafe: check if the file is present in the repo.
	if (! realpath "$repo_root/$file" > /dev/null 2>&1); then
		echo "File does not exist in the repo: $file";
		continue;
	fi;


	# Check if the file exists in the home directory.
	fs_path=`realpath "$HOME/$file" 2>/dev/null`;
	if [ $? -ne 0 ]; then
		echo "File not for found: $file";
		continue;
	fi;


	# Determine the file path in the repository and create a directory
	# if necessary.
	repo_path="$repo_root/$file";	
	if [[ "$file" =~ .*/.* ]]; then
		mkdir -p "${repo_path%/*}";
		if [ $? -ne 0 ]; then
			echo "Couldn't make directory for file: $file";
			continue;
		fi;
	else
		dir="$repo_root"
	fi;


	# Check if the files differ, and if so copy them to the repo.
	if (! diff -q "$fs_path" "$repo_path" > /dev/null 2>&1); then
		if (! cp "$fs_path" "$repo_path" > /dev/null 2>&1); then
			echo "Failed to update file: $file";
			continue;
		fi;

		updated_index=$((updated_index+1));
		f_updated[$updated_index]="$file";
	else
		up2date_index=$((up2date_index+1));
		f_up2date[$up2date_index]="$file";
	fi;
done;




if [ "$updated_index" -gt 0 ]; then
	echo "Updated:";
	for file in "${f_updated[@]}"; do
		echo "  $file";
	done;

	if [ "$up2date_index" -gt 0 ]; then
		echo;
	fi;
fi;


if [ "$up2date_index" -gt 0 ]; then
	echo "Up-to-date:";
	for file in "${f_up2date[@]}"; do
		echo "  $file";
	done;
fi;
